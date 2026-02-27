const RetrievalFlowNodeServiceConfiguration = @import("retrieval_flow_node_service_configuration.zig").RetrievalFlowNodeServiceConfiguration;

/// Contains configurations for a Retrieval node in a flow. This node retrieves
/// data from the Amazon S3 location that you specify and returns it as the
/// output.
pub const RetrievalFlowNodeConfiguration = struct {
    /// Contains configurations for the service to use for retrieving data to return
    /// as the output from the node.
    service_configuration: RetrievalFlowNodeServiceConfiguration,

    pub const json_field_names = .{
        .service_configuration = "serviceConfiguration",
    };
};
