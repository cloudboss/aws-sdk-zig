/// Describes the configuration for experiment logging to Amazon S3.
pub const ExperimentTemplateS3LogConfiguration = struct {
    /// The name of the destination bucket.
    bucket_name: ?[]const u8 = null,

    /// The bucket prefix.
    prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .prefix = "prefix",
    };
};
