/// Specifies the configuration for experiment logging to Amazon S3.
pub const ExperimentTemplateS3LogConfigurationInput = struct {
    /// The name of the destination bucket.
    bucket_name: []const u8,

    /// The bucket prefix.
    prefix: ?[]const u8,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .prefix = "prefix",
    };
};
