pub const SourceRevisionType = enum {
    commit_id,
    image_digest,
    s3_object_version_id,
    s3_object_key,

    pub const json_field_names = .{
        .commit_id = "COMMIT_ID",
        .image_digest = "IMAGE_DIGEST",
        .s3_object_version_id = "S3_OBJECT_VERSION_ID",
        .s3_object_key = "S3_OBJECT_KEY",
    };
};
