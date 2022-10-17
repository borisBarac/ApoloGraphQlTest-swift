import Foundation
import Apollo
import ApolloAPI

public class MockInterceptor: ApolloInterceptor, Cancellable {
    var mockResponceString: String? = nil

    init(mockResponceString: String? = nil) {
        self.mockResponceString = mockResponceString
    }

    public func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
            let mockCode = mockResponceString != nil ? 200 : 500
            let httpMock = HTTPURLResponse(url: request.graphQLEndpoint, statusCode: mockCode, httpVersion: "HTTP/1.1", headerFields: request.additionalHeaders)


            chain.proceedAsync(request: request,
                               response: HTTPResponse(response: httpMock!,
                                                      rawData: (mockResponceString ?? "").data(using: .utf8)!,
                                                      parsedResponse: nil),
                               completion: completion)
        }

    public func cancel() {
    }
}

// !!!!!!!
// !!!!!!!
// Mock is not the same like the responce from the web console, it needs extra type information
// !!!!!!!
// !!!!!!!

//let example = """
//            {
//              "data": {
//                "DeadCharacters": {
//                  "__typename": "Characters",
//                  "results": [
//                    {
//                      "__typename": "Character",
//                      "name": "Adjudicator Rick",
//                      "status": "Dead",
//                      "type": "",
//                      "image": "https://rickandmortyapi.com/api/character/avatar/8.jpeg",
//                      "id": "8"
//                    },
//                    {
//                      "__typename": "Character",
//                      "name": "Agency Director",
//                      "status": "Dead",
//                      "type": "",
//                      "image": "https://rickandmortyapi.com/api/character/avatar/9.jpeg",
//                      "id": "9"
//                    }
//                  ]
//                }
//              }
//            }
//            """
