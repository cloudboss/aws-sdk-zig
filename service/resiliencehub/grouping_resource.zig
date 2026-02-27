const LogicalResourceId = @import("logical_resource_id.zig").LogicalResourceId;
const PhysicalResourceId = @import("physical_resource_id.zig").PhysicalResourceId;

/// Indicates the resource that will be grouped in the recommended Application
/// Component (AppComponent).
pub const GroupingResource = struct {
    /// Indicates the logical identifier of the resource.
    logical_resource_id: LogicalResourceId,

    /// Indicates the physical identifier of the resource.
    physical_resource_id: PhysicalResourceId,

    /// Indicates the resource name.
    resource_name: []const u8,

    /// Indicates the resource type.
    resource_type: []const u8,

    /// Indicates the identifier of the source AppComponents in which the resources
    /// were previously grouped into.
    source_app_component_ids: []const []const u8,

    pub const json_field_names = .{
        .logical_resource_id = "logicalResourceId",
        .physical_resource_id = "physicalResourceId",
        .resource_name = "resourceName",
        .resource_type = "resourceType",
        .source_app_component_ids = "sourceAppComponentIds",
    };
};
