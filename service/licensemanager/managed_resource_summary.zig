const ResourceType = @import("resource_type.zig").ResourceType;

/// Summary information about a managed resource.
pub const ManagedResourceSummary = struct {
    /// Number of resources associated with licenses.
    association_count: ?i64 = null,

    /// Type of resource associated with a license.
    resource_type: ?ResourceType = null,

    pub const json_field_names = .{
        .association_count = "AssociationCount",
        .resource_type = "ResourceType",
    };
};
