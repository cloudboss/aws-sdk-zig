/// The S3 location.
pub const S3Location = struct {
    /// The S3 bucket.
    bucket: ?[]const u8 = null,

    /// The S3 key.
    key: ?[]const u8 = null,

    /// The S3 bucket version.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "bucket",
        .key = "key",
        .version = "version",
    };
};
