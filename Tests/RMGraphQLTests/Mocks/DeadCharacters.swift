import Foundation
import ApolloAPI
import Api
@testable import RMGraphQL

private let data: [String: AnyHashable] = [
    "data": [
        "DeadCharacters": [
            "results": [
                [
                    "name": "Adjudicator Rick",
                    "status": "Dead",
                    "type": "",
                    "image": "https://rickandmortyapi.com/api/character/avatar/8.jpeg",
                    "id": "8"
                ],
                [
                    "name": "Agency Director",
                    "status": "Dead",
                    "type": "",
                    "image": "https://rickandmortyapi.com/api/character/avatar/9.jpeg",
                    "id": "9"
                ],
                [
                    "name": "Alan Rails",
                    "status": "Dead",
                    "type": "Superhuman (Ghost trains summoner)",
                    "image": "https://rickandmortyapi.com/api/character/avatar/10.jpeg",
                    "id": "10"
                ]
            ]

        ]
    ]
]

let deadCharactersQueryData = DeadCharactersQuery.Data(data: DataDict(data, variables: [:]))

