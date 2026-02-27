const DataIntegrationFlowS3Options = @import("data_integration_flow_s3_options.zig").DataIntegrationFlowS3Options;

/// The S3 DataIntegrationFlow source configuration parameters.
pub const DataIntegrationFlowS3SourceConfiguration = struct {
    /// The bucketName of the S3 source objects.
    bucket_name: []const u8,

    /// The other options of the S3 DataIntegrationFlow source.
    options: ?DataIntegrationFlowS3Options,

    /// The prefix of the S3 source objects. To trigger data ingestion, S3 files
    /// need to be put under `s3://*bucketName*/*prefix*/`.
    prefix: []const u8,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .options = "options",
        .prefix = "prefix",
    };
};
