/// Information required to find a specific file in an Amazon S3 bucket.
pub const S3Path = struct {
    /// The name of the S3 bucket that contains the file.
    bucket: []const u8,

    /// The name of the file.
    key: []const u8,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .key = "Key",
    };
};
