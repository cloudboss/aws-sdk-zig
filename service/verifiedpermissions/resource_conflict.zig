const ResourceType = @import("resource_type.zig").ResourceType;

/// Contains information about a resource conflict.
pub const ResourceConflict = struct {
    /// The unique identifier of the resource involved in a conflict.
    resource_id: []const u8,

    /// The type of the resource involved in a conflict.
    resource_type: ResourceType,

    pub const json_field_names = .{
        .resource_id = "resourceId",
        .resource_type = "resourceType",
    };
};
