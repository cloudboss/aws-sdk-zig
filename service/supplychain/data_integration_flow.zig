const DataIntegrationFlowSource = @import("data_integration_flow_source.zig").DataIntegrationFlowSource;
const DataIntegrationFlowTarget = @import("data_integration_flow_target.zig").DataIntegrationFlowTarget;
const DataIntegrationFlowTransformation = @import("data_integration_flow_transformation.zig").DataIntegrationFlowTransformation;

/// The DataIntegrationFlow details.
pub const DataIntegrationFlow = struct {
    /// The DataIntegrationFlow creation timestamp.
    created_time: i64,

    /// The DataIntegrationFlow instance ID.
    instance_id: []const u8,

    /// The DataIntegrationFlow last modified timestamp.
    last_modified_time: i64,

    /// The DataIntegrationFlow name.
    name: []const u8,

    /// The DataIntegrationFlow source configurations.
    sources: []const DataIntegrationFlowSource,

    /// The DataIntegrationFlow target configuration.
    target: DataIntegrationFlowTarget,

    /// The DataIntegrationFlow transformation configurations.
    transformation: DataIntegrationFlowTransformation,

    pub const json_field_names = .{
        .created_time = "createdTime",
        .instance_id = "instanceId",
        .last_modified_time = "lastModifiedTime",
        .name = "name",
        .sources = "sources",
        .target = "target",
        .transformation = "transformation",
    };
};
