/// The file in Amazon S3 where your data is saved.
pub const File = struct {
    /// The name of the Amazon S3 bucket from which data is imported.
    bucket: []const u8,

    /// The key of the Amazon S3 object that contains your data. Each object has a
    /// key that is a unique
    /// identifier. Each object has exactly one key.
    key: []const u8,

    /// The version ID to identify a specific version of the Amazon S3 object that
    /// contains your
    /// data.
    version_id: ?[]const u8,

    pub const json_field_names = .{
        .bucket = "bucket",
        .key = "key",
        .version_id = "versionId",
    };
};
