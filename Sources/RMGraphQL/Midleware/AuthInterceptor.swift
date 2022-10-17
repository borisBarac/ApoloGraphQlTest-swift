import Foundation
import Apollo
import ApolloAPI

public typealias AuthBlockType = ((AdditionalHeaders) -> ())

class AuthInterceptor: ApolloInterceptor, Cancellable {
    typealias AuthBlockType = ((AdditionalHeaders) -> ())
    let authBlock: AuthBlockType?

    public init(authBlock: AuthBlockType?)  {
        self.authBlock = authBlock
    }

    public func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
            authBlock?(request)

            chain.proceedAsync(request: request,
                               response: response,
                               completion: completion)

        }

    public func cancel() {
    }
}

public protocol AdditionalHeaders {
    var additionalHeaders: [String: String] { get set }
}

extension HTTPRequest: AdditionalHeaders {

}
