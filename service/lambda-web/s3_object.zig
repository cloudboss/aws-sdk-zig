/// The Amazon S3 location of a deployment artifact.
pub const S3Object = struct {
    /// The name of the Amazon S3 bucket. Must be between 3 and 63 characters.
    bucket: []const u8,

    /// The Amazon S3 object key. Must be between 1 and 1024 characters.
    key: []const u8,

    /// The version ID of the Amazon S3 object.
    version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "bucket",
        .key = "key",
        .version_id = "versionId",
    };
};
