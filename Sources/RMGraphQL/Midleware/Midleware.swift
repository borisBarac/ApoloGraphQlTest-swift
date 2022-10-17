import Foundation
import Apollo
import ApolloAPI

struct NetworkInterceptorProvider: InterceptorProvider {

    // These properties will remain the same throughout the life of the `InterceptorProvider`, even though they
    // will be handed to different interceptors.
    private let store: ApolloStore
    private let client: URLSessionClient
    private let logger: Logger
    private let authBlock: AuthBlockType?
    private let mockInterceptor: MockInterceptor?

    init(store: ApolloStore, client: URLSessionClient, logger: Logger, authBlock: AuthBlockType?, mockInterceptor: MockInterceptor? = nil) {
        self.store = store
        self.client = client
        self.logger = logger
        self.authBlock = authBlock
        self.mockInterceptor = mockInterceptor
    }

    func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        [
            MaxRetryInterceptor(),
            CacheReadInterceptor(store: self.store),
            RequestLoggingInterceptor(logger: logger),
            AuthInterceptor(authBlock: authBlock),
            mockInterceptor ?? NetworkFetchInterceptor(client: self.client),
            ResponseLoggingInterceptor(logger: logger),
            ResponseCodeInterceptor(),
            JSONResponseParsingInterceptor(),
            AutomaticPersistedQueryInterceptor(),
            CacheWriteInterceptor(store: self.store)
        ]
    }


}
