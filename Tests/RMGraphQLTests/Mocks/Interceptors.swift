import Foundation
import ApolloAPI
import Api
@testable import RMGraphQL

extension MockInterceptor {
    static var passMock: MockInterceptor {
        MockInterceptor(mockResponceString: example)
    }

    static var failMock: MockInterceptor {
        // defaults to fail
        MockInterceptor()
    }
}


private  let example = """
                    {
                      "data": {
                        "DeadCharacters": {
                          "__typename": "Characters",
                          "results": [
                            {
                              "__typename": "Character",
                              "name": "Adjudicator Rick",
                              "status": "Dead",
                              "type": "",
                              "image": "https://rickandmortyapi.com/api/character/avatar/8.jpeg",
                              "id": "8"
                            },
                            {
                              "__typename": "Character",
                              "name": "Agency Director",
                              "status": "Dead",
                              "type": "",
                              "image": "https://rickandmortyapi.com/api/character/avatar/9.jpeg",
                              "id": "9"
                            }
                          ]
                        }
                      }
                    }
                    """

