const LogicalResourceId = @import("logical_resource_id.zig").LogicalResourceId;

/// Defines a resource identifier for the drifted resource.
pub const ResourceIdentifier = struct {
    /// Logical identifier of the drifted resource.
    logical_resource_id: ?LogicalResourceId = null,

    /// Type of the drifted resource.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .logical_resource_id = "logicalResourceId",
        .resource_type = "resourceType",
    };
};
