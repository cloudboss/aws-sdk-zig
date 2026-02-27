/// Contains configurations for the Amazon S3 location from which to retrieve
/// data to return as the output from the node.
pub const RetrievalFlowNodeS3Configuration = struct {
    /// The name of the Amazon S3 bucket from which to retrieve data.
    bucket_name: []const u8 = "",

    pub const json_field_names = .{
        .bucket_name = "bucketName",
    };
};
