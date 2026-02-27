const S3OutputFormatConfig = @import("s3_output_format_config.zig").S3OutputFormatConfig;

/// The properties that are applied when Amazon S3 is used as a destination.
pub const S3DestinationProperties = struct {
    /// The Amazon S3 bucket name in which Amazon AppFlow places the transferred
    /// data.
    bucket_name: []const u8,

    /// The object key for the destination bucket in which Amazon AppFlow places the
    /// files.
    bucket_prefix: ?[]const u8,

    s_3_output_format_config: ?S3OutputFormatConfig,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .bucket_prefix = "bucketPrefix",
        .s_3_output_format_config = "s3OutputFormatConfig",
    };
};
