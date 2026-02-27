const LogicalResourceId = @import("logical_resource_id.zig").LogicalResourceId;
const PhysicalResourceId = @import("physical_resource_id.zig").PhysicalResourceId;

/// Defines a resource that is not supported by Resilience Hub.
pub const UnsupportedResource = struct {
    /// Logical resource identifier for the unsupported resource.
    logical_resource_id: LogicalResourceId,

    /// Physical resource identifier for the unsupported resource.
    physical_resource_id: PhysicalResourceId,

    /// The type of resource.
    resource_type: []const u8,

    /// The status of the unsupported resource.
    unsupported_resource_status: ?[]const u8,

    pub const json_field_names = .{
        .logical_resource_id = "logicalResourceId",
        .physical_resource_id = "physicalResourceId",
        .resource_type = "resourceType",
        .unsupported_resource_status = "unsupportedResourceStatus",
    };
};
