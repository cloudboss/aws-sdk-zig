/// The location of the S3 bucket that contains a revision.
pub const S3ArtifactLocation = struct {
    /// The name of the S3 bucket.
    bucket_name: []const u8,

    /// The key of the object in the S3 bucket, which uniquely identifies the object
    /// in the
    /// bucket.
    object_key: []const u8,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .object_key = "objectKey",
    };
};
