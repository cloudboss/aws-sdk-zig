pub const ExceptionCause = enum {
    insufficient_s3_bucket_policy,
    s3_access_denied,

    pub const json_field_names = .{
        .insufficient_s3_bucket_policy = "InsufficientS3BucketPolicy",
        .s3_access_denied = "S3AccessDenied",
    };
};
