import Foundation
import Apollo
import ApolloAPI

struct NetworkInterceptorProvider: InterceptorProvider {

    // These properties will remain the same throughout the life of the `InterceptorProvider`, even though they
    // will be handed to different interceptors.
    private let store: ApolloStore
    private let client: URLSessionClient
    private let logger: Logger

    init(store: ApolloStore, client: URLSessionClient, logger: Logger) {
        self.store = store
        self.client = client
        self.logger = logger
    }

    func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        return [
            MaxRetryInterceptor(),
            CacheReadInterceptor(store: self.store),
            RequestLoggingInterceptor(logger: logger),
            NetworkFetchInterceptor(client: self.client),
            ResponseLoggingInterceptor(logger: logger),
            ResponseCodeInterceptor(),
            JSONResponseParsingInterceptor(),
            AutomaticPersistedQueryInterceptor(),
            CacheWriteInterceptor(store: self.store)
        ]
    }
}
