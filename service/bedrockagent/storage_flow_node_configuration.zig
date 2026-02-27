const StorageFlowNodeServiceConfiguration = @import("storage_flow_node_service_configuration.zig").StorageFlowNodeServiceConfiguration;

/// Contains configurations for a Storage node in a flow. This node stores the
/// input in an Amazon S3 location that you specify.
pub const StorageFlowNodeConfiguration = struct {
    /// Contains configurations for the service to use for storing the input into
    /// the node.
    service_configuration: StorageFlowNodeServiceConfiguration,

    pub const json_field_names = .{
        .service_configuration = "serviceConfiguration",
    };
};
