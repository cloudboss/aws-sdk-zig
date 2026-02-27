const ExternalId = @import("external_id.zig").ExternalId;
const UniqueAttribute = @import("unique_attribute.zig").UniqueAttribute;

/// A unique identifier for a user or group that is not the primary identifier.
/// This value can be an identifier from an external identity provider (IdP)
/// that is associated with the user, the group, or a unique attribute.
pub const AlternateIdentifier = union(enum) {
    /// The identifier issued to this resource by an external identity provider.
    external_id: ?ExternalId,
    /// An entity attribute that's unique to a specific entity.
    unique_attribute: ?UniqueAttribute,

    pub const json_field_names = .{
        .external_id = "ExternalId",
        .unique_attribute = "UniqueAttribute",
    };
};
