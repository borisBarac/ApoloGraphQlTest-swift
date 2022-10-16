import Foundation
import Apollo
import ApolloAPI

class ResponseLoggingInterceptor: ApolloInterceptor {
    private let logger: Logger

    init(logger: Logger) {
        self.logger = logger
    }

    enum ResponseLoggingError: Error {
        case notYetReceived
    }

    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        defer {
            // Even if we can't log, we still want to keep going.
            chain.proceedAsync(
                request: request,
                response: response,
                completion: completion
            )
        }

        guard let receivedResponse = response else {
            chain.handleErrorAsync(
                ResponseLoggingError.notYetReceived,
                request: request,
                response: response,
                completion: completion
            )
            return
        }

        logger.log(message: "HTTP Response: \(receivedResponse.httpResponse)")

        if let stringData = String(bytes: receivedResponse.rawData, encoding: .utf8) {
            logger.log(message: "Data: \(stringData)")
        } else {
            logger.log(message: "Could not convert data to string!", logType: .error)
        }
    }
}
