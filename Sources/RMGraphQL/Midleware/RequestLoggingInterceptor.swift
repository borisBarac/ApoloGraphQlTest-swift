import Foundation
import Apollo
import ApolloAPI

class RequestLoggingInterceptor: ApolloInterceptor {
    private let logger: Logger

    init(logger: Logger) {
        self.logger = logger
    }

    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        logger.log(message: "Outgoing request: \(request)")
        chain.proceedAsync(
            request: request,
            response: response,
            completion: completion
        )
    }
}
