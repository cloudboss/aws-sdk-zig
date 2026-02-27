/// Describes an update for the Amazon S3 code content location for an
/// application.
pub const S3ContentLocationUpdate = struct {
    /// The new Amazon Resource Name (ARN) for the S3 bucket containing the
    /// application code.
    bucket_arn_update: ?[]const u8,

    /// The new file key for the object containing the application code.
    file_key_update: ?[]const u8,

    /// The new version of the object containing the application code.
    object_version_update: ?[]const u8,

    pub const json_field_names = .{
        .bucket_arn_update = "BucketARNUpdate",
        .file_key_update = "FileKeyUpdate",
        .object_version_update = "ObjectVersionUpdate",
    };
};
