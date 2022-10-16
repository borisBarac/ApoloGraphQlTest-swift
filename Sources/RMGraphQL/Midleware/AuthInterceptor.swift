import Foundation
import Apollo
import ApolloAPI

/// fork of NetworkFetchInterceptor with AUTH block
/// NetworkFetchInterceptor is not open, so overide does not work
class AuthInterceptor: ApolloInterceptor, Cancellable {
    let client: URLSessionClient
    let authBlock: ((URLRequest) -> URLRequest)?

    @Atomic private var currentTask: URLSessionTask?

    /// Designated initializer.
    ///
    /// - Parameter client: The `URLSessionClient` to use to fetch data
    public init(client: URLSessionClient, authBlock: ((URLRequest) -> URLRequest)?) {
        self.client = client
        self.authBlock = authBlock
    }

    public func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {

            let urlRequest: URLRequest
            do {
                let req = try request.toURLRequest()
                urlRequest = authBlock?(req) ?? req
                
            } catch {
                chain.handleErrorAsync(error,
                                       request: request,
                                       response: response,
                                       completion: completion)
                return
            }

            let task = self.client.sendRequest(urlRequest) { [weak self] result in
                guard let self = self else {
                    return
                }

                defer {
                    self.$currentTask.mutate { $0 = nil }
                }

                guard !chain.isCancelled else {
                    return
                }

                switch result {
                case .failure(let error):
                    chain.handleErrorAsync(error,
                                           request: request,
                                           response: response,
                                           completion: completion)
                case .success(let (data, httpResponse)):
                    let response = HTTPResponse<Operation>(response: httpResponse,
                                                           rawData: data,
                                                           parsedResponse: nil)
                    chain.proceedAsync(request: request,
                                       response: response,
                                       completion: completion)
                }
            }

            self.$currentTask.mutate { $0 = task }
        }

    public func cancel() {
        guard let task = self.currentTask else {
            return
        }

        task.cancel()
    }
}
