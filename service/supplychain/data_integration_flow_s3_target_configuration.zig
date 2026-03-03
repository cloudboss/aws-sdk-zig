const DataIntegrationFlowS3Options = @import("data_integration_flow_s3_options.zig").DataIntegrationFlowS3Options;

/// The S3 DataIntegrationFlow target configuration parameters.
pub const DataIntegrationFlowS3TargetConfiguration = struct {
    /// The bucketName of the S3 target objects.
    bucket_name: []const u8,

    /// The S3 DataIntegrationFlow target options.
    options: ?DataIntegrationFlowS3Options = null,

    /// The prefix of the S3 target objects.
    prefix: []const u8,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .options = "options",
        .prefix = "prefix",
    };
};
