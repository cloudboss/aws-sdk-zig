const aws = @import("aws");

const AttributeValue = @import("attribute_value.zig").AttributeValue;
const EntityIdentifier = @import("entity_identifier.zig").EntityIdentifier;
const CedarTagValue = @import("cedar_tag_value.zig").CedarTagValue;

/// Contains information about an entity that can be referenced in a Cedar
/// policy.
///
/// This data type is used as one of the fields in the
/// [EntitiesDefinition](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_EntitiesDefinition.html) structure.
///
/// `{ "identifier": { "entityType": "Photo", "entityId": "VacationPhoto94.jpg"
/// }, "attributes": {}, "parents": [ { "entityType": "Album", "entityId":
/// "alice_folder" } ] }`
pub const EntityItem = struct {
    /// A list of attributes for the entity.
    attributes: ?[]const aws.map.MapEntry(AttributeValue) = null,

    /// The identifier of the entity.
    identifier: EntityIdentifier,

    /// The parent entities in the hierarchy that contains the entity. A principal
    /// or resource entity can be defined with at most 99 *transitive parents* per
    /// authorization request.
    ///
    /// A transitive parent is an entity in the hierarchy of entities including all
    /// direct parents, and parents of parents. For example, a user can be a member
    /// of 91 groups if one of those groups is a member of eight groups, for a total
    /// of 100: one entity, 91 entity parents, and eight parents of parents.
    parents: ?[]const EntityIdentifier = null,

    /// A list of cedar tags for the entity.
    tags: ?[]const aws.map.MapEntry(CedarTagValue) = null,

    pub const json_field_names = .{
        .attributes = "attributes",
        .identifier = "identifier",
        .parents = "parents",
        .tags = "tags",
    };
};
