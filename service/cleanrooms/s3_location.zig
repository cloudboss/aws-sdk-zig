/// The S3 location.
pub const S3Location = struct {
    /// The bucket name.
    bucket: []const u8,

    /// The object key.
    key: []const u8,

    pub const json_field_names = .{
        .bucket = "bucket",
        .key = "key",
    };
};
