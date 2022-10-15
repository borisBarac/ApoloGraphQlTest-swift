// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI
@_exported import enum ApolloAPI.GraphQLEnum
@_exported import enum ApolloAPI.GraphQLNullable
import Api

public struct CharacterFields: Api.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString { """
    fragment characterFields on Character {
      __typename
      name
      status
      type
      image
      id
    }
    """ }

  public let __data: DataDict
  public init(data: DataDict) { __data = data }

  public static var __parentType: ParentType { Api.Objects.Character }
  public static var __selections: [Selection] { [
    .field("name", String?.self),
    .field("status", String?.self),
    .field("type", String?.self),
    .field("image", String?.self),
    .field("id", Api.ID?.self),
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
}
