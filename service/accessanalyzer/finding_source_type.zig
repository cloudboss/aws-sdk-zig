pub const FindingSourceType = enum {
    policy,
    bucket_acl,
    s3_access_point,
    s3_access_point_account,

    pub const json_field_names = .{
        .policy = "POLICY",
        .bucket_acl = "BUCKET_ACL",
        .s3_access_point = "S3_ACCESS_POINT",
        .s3_access_point_account = "S3_ACCESS_POINT_ACCOUNT",
    };
};
