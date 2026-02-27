const RetrievalFlowNodeS3Configuration = @import("retrieval_flow_node_s3_configuration.zig").RetrievalFlowNodeS3Configuration;

/// Contains configurations for the service to use for retrieving data to return
/// as the output from the node.
pub const RetrievalFlowNodeServiceConfiguration = union(enum) {
    /// Contains configurations for the Amazon S3 location from which to retrieve
    /// data to return as the output from the node.
    s_3: ?RetrievalFlowNodeS3Configuration,

    pub const json_field_names = .{
        .s_3 = "s3",
    };
};
