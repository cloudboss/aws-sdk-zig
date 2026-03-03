const S3InputFormatConfig = @import("s3_input_format_config.zig").S3InputFormatConfig;

/// The properties that are applied when Amazon S3 is being used as the flow
/// source.
pub const S3SourceProperties = struct {
    /// The Amazon S3 bucket name where the source files are stored.
    bucket_name: []const u8,

    /// The object key for the Amazon S3 bucket in which the source files are
    /// stored.
    bucket_prefix: ?[]const u8 = null,

    s_3_input_format_config: ?S3InputFormatConfig = null,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .bucket_prefix = "bucketPrefix",
        .s_3_input_format_config = "s3InputFormatConfig",
    };
};
