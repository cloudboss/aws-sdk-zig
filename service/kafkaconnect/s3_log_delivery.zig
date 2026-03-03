/// Details about delivering logs to Amazon S3.
pub const S3LogDelivery = struct {
    /// The name of the S3 bucket that is the destination for log delivery.
    bucket: ?[]const u8 = null,

    /// Specifies whether connector logs get sent to the specified Amazon S3
    /// destination.
    enabled: bool = false,

    /// The S3 prefix that is the destination for log delivery.
    prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "bucket",
        .enabled = "enabled",
        .prefix = "prefix",
    };
};
