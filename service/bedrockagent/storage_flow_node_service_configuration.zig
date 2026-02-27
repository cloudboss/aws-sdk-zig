const StorageFlowNodeS3Configuration = @import("storage_flow_node_s3_configuration.zig").StorageFlowNodeS3Configuration;

/// Contains configurations for the service to use for storing the input into
/// the node.
pub const StorageFlowNodeServiceConfiguration = union(enum) {
    /// Contains configurations for the Amazon S3 location in which to store the
    /// input into the node.
    s_3: ?StorageFlowNodeS3Configuration,

    pub const json_field_names = .{
        .s_3 = "s3",
    };
};
