const UpsolverS3OutputFormatConfig = @import("upsolver_s3_output_format_config.zig").UpsolverS3OutputFormatConfig;

/// The properties that are applied when Upsolver is used as a destination.
pub const UpsolverDestinationProperties = struct {
    /// The Upsolver Amazon S3 bucket name in which Amazon AppFlow places the
    /// transferred data.
    bucket_name: []const u8,

    /// The object key for the destination Upsolver Amazon S3 bucket in which Amazon
    /// AppFlow places the files.
    bucket_prefix: ?[]const u8 = null,

    /// The configuration that determines how data is formatted when Upsolver is
    /// used as the flow
    /// destination.
    s_3_output_format_config: UpsolverS3OutputFormatConfig,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .bucket_prefix = "bucketPrefix",
        .s_3_output_format_config = "s3OutputFormatConfig",
    };
};
