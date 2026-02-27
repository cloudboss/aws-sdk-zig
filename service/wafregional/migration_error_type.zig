pub const MigrationErrorType = enum {
    entity_not_supported,
    entity_not_found,
    s3_bucket_no_permission,
    s3_bucket_not_accessible,
    s3_bucket_not_found,
    s3_bucket_invalid_region,
    s3_internal_error,

    pub const json_field_names = .{
        .entity_not_supported = "ENTITY_NOT_SUPPORTED",
        .entity_not_found = "ENTITY_NOT_FOUND",
        .s3_bucket_no_permission = "S3_BUCKET_NO_PERMISSION",
        .s3_bucket_not_accessible = "S3_BUCKET_NOT_ACCESSIBLE",
        .s3_bucket_not_found = "S3_BUCKET_NOT_FOUND",
        .s3_bucket_invalid_region = "S3_BUCKET_INVALID_REGION",
        .s3_internal_error = "S3_INTERNAL_ERROR",
    };
};
