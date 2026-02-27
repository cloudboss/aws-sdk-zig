const EntityIdentifier = @import("entity_identifier.zig").EntityIdentifier;

/// Contains information about a principal or resource that can be referenced in
/// a Cedar policy.
///
/// This data type is used as part of the
/// [PolicyFilter](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_PolicyFilter.html) structure that is used as a request parameter for the [ListPolicies](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_ListPolicies.html) operation..
pub const EntityReference = union(enum) {
    /// The identifier of the entity. It can consist of either an EntityType and
    /// EntityId, a principal, or a resource.
    identifier: ?EntityIdentifier,
    /// Used to indicate that a principal or resource is not specified. This can be
    /// used to search for policies that are not associated with a specific
    /// principal or resource.
    unspecified: ?bool,

    pub const json_field_names = .{
        .identifier = "identifier",
        .unspecified = "unspecified",
    };
};
