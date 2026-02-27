/// The details of a flow execution with S3 source.
pub const DataIntegrationFlowS3Source = struct {
    /// The S3 bucket name of the S3 source.
    bucket_name: []const u8,

    /// The S3 object key of the S3 source.
    key: []const u8,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .key = "key",
    };
};
