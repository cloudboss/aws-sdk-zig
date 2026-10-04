/// Specifies the Amazon S3 location of code artifacts that workflows use during
/// execution.
pub const S3Location = struct {
    /// The name of the Amazon S3 bucket.
    bucket: []const u8,

    /// The key of the code artifact within the Amazon S3 bucket.
    object_key: []const u8,

    /// The version ID of the object in Amazon S3. If not specified, the latest
    /// version is used.
    version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .object_key = "ObjectKey",
        .version_id = "VersionId",
    };
};
