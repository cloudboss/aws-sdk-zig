/// Details about delivering logs to S3.
pub const ReplicatorS3 = struct {
    /// The S3 bucket that is the destination for log delivery.
    bucket: ?[]const u8 = null,

    /// Whether log delivery to S3 is enabled.
    enabled: bool,

    /// The S3 prefix that is the destination for log delivery.
    prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .enabled = "Enabled",
        .prefix = "Prefix",
    };
};
