const S3OutputConfigurations = @import("s3_output_configurations.zig").S3OutputConfigurations;

/// Describes the destination Amazon Simple Storage Service (Amazon S3) bucket
/// name and object
/// keys of a data exports file.
pub const S3Destination = struct {
    /// The name of the Amazon S3 bucket used as the destination of a data export
    /// file.
    s3_bucket: []const u8,

    /// The output configuration for the data export.
    s3_output_configurations: S3OutputConfigurations,

    /// The S3 path prefix you want prepended to the name of your data export.
    s3_prefix: []const u8,

    /// The S3 bucket Region.
    s3_region: []const u8,

    pub const json_field_names = .{
        .s3_bucket = "S3Bucket",
        .s3_output_configurations = "S3OutputConfigurations",
        .s3_prefix = "S3Prefix",
        .s3_region = "S3Region",
    };
};
