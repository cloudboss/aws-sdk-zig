/// Contains configurations for the Amazon S3 location in which to store the
/// input into the node.
pub const StorageFlowNodeS3Configuration = struct {
    /// The name of the Amazon S3 bucket in which to store the input into the node.
    bucket_name: []const u8 = "",

    pub const json_field_names = .{
        .bucket_name = "bucketName",
    };
};
