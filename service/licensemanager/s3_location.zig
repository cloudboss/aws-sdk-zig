/// Details of the S3 bucket that report generator reports are published to.
pub const S3Location = struct {
    /// Name of the S3 bucket reports are published to.
    bucket: ?[]const u8 = null,

    /// Prefix of the S3 bucket reports are published to.
    key_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "bucket",
        .key_prefix = "keyPrefix",
    };
};
