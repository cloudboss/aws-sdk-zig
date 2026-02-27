const S3DestinationConfig = @import("s3_destination_config.zig").S3DestinationConfig;

/// The configuration for the destination where the harvested content will be
/// exported.
pub const Destination = struct {
    /// The configuration for exporting harvested content to an S3 bucket. This
    /// includes details such as the bucket name and destination path within the
    /// bucket.
    s3_destination: S3DestinationConfig,

    pub const json_field_names = .{
        .s3_destination = "S3Destination",
    };
};
