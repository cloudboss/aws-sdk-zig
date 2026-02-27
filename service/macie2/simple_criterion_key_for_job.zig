/// The property to use in a condition that determines whether an S3 bucket is
/// included or excluded from a classification job. Valid values are:
pub const SimpleCriterionKeyForJob = enum {
    account_id,
    s3_bucket_name,
    s3_bucket_effective_permission,
    s3_bucket_shared_access,

    pub const json_field_names = .{
        .account_id = "ACCOUNT_ID",
        .s3_bucket_name = "S3_BUCKET_NAME",
        .s3_bucket_effective_permission = "S3_BUCKET_EFFECTIVE_PERMISSION",
        .s3_bucket_shared_access = "S3_BUCKET_SHARED_ACCESS",
    };
};
