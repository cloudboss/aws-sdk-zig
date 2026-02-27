/// Amazon S3 manifest file location.
pub const ManifestFileLocation = struct {
    /// Amazon S3 bucket.
    bucket: []const u8,

    /// Amazon S3 key that identifies an object.
    key: []const u8,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .key = "Key",
    };
};
