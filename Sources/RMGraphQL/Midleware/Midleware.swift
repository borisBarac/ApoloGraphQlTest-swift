import Foundation
import Apollo
import ApolloAPI

struct NetworkInterceptorProvider: InterceptorProvider {

    // These properties will remain the same throughout the life of the `InterceptorProvider`, even though they
    // will be handed to different interceptors.
    private let store: ApolloStore
    private let client: URLSessionClient
    private let logger: Logger
    private let authBlock: ((URLRequest) -> URLRequest)?

    init(store: ApolloStore, client: URLSessionClient, logger: Logger, authBlock: ((URLRequest) -> URLRequest)?) {
        self.store = store
        self.client = client
        self.logger = logger
        self.authBlock = authBlock
    }

    func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {

        let networkInterceptor: ApolloInterceptor = authBlock != nil ? AuthInterceptor(client: self.client, authBlock: authBlock) : NetworkFetchInterceptor(client: self.client)

        return [
            MaxRetryInterceptor(),
            CacheReadInterceptor(store: self.store),
            RequestLoggingInterceptor(logger: logger),
            networkInterceptor,
            ResponseLoggingInterceptor(logger: logger),
            ResponseCodeInterceptor(),
            JSONResponseParsingInterceptor(),
            AutomaticPersistedQueryInterceptor(),
            CacheWriteInterceptor(store: self.store)
        ]
    }
}
