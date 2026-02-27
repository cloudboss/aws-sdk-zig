const policyOwnerEntityType = @import("policy_owner_entity_type.zig").policyOwnerEntityType;

/// Contains details about the specified entity (user or role).
///
/// This data type is an element of the
/// [EntityDetails](https://docs.aws.amazon.com/IAM/latest/APIReference/API_EntityDetails.html)
/// object.
pub const EntityInfo = struct {
    arn: []const u8,

    /// The identifier of the entity (user or role).
    id: []const u8,

    /// The name of the entity (user or role).
    name: []const u8,

    /// The path to the entity (user or role). For more information about paths, see
    /// [IAM
    /// identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the *IAM User Guide*.
    path: ?[]const u8,

    /// The type of entity (user or role).
    type: policyOwnerEntityType,
};
