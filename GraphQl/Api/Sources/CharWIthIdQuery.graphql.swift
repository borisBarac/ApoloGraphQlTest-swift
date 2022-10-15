// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI
@_exported import enum ApolloAPI.GraphQLEnum
@_exported import enum ApolloAPI.GraphQLNullable
import Api

public class CharWIthIdQuery: GraphQLQuery {
  public static let operationName: String = "CharWIthId"
  public static let document: DocumentType = .notPersisted(
    definition: .init(
      """
      query CharWIthId($id: ID!) {
        character(id: $id) {
          __typename
          ...characterFields
        }
      }
      """,
      fragments: [CharacterFields.self]
    ))

  public var id: Api.ID

  public init(id: Api.ID) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: Api.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ParentType { Api.Objects.Query }
    public static var __selections: [Selection] { [
      .field("character", Character?.self, arguments: ["id": .variable("id")]),
    ] }

    /// Get a specific character by ID
    public var character: Character? { __data["character"] }

    /// Character
    ///
    /// Parent Type: `Character`
    public struct Character: Api.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ParentType { Api.Objects.Character }
      public static var __selections: [Selection] { [
        .fragment(CharacterFields.self),
      ] }

      /// The name of the character.
      public var name: String? { __data["name"] }
      /// The status of the character ('Alive', 'Dead' or 'unknown').
      public var status: String? { __data["status"] }
      /// The type or subspecies of the character.
      public var type: String? { __data["type"] }
      /// Link to the character's image.
      /// All images are 300x300px and most are medium shots or portraits since they are intended to be used as avatars.
      public var image: String? { __data["image"] }
      /// The id of the character.
      public var id: Api.ID? { __data["id"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public var characterFields: CharacterFields { _toFragment() }
      }
    }
  }
}
