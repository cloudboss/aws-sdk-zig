pub const ValidatePolicyResourceType = enum {
    s3_bucket,
    s3_access_point,
    s3_multi_region_access_point,
    s3_object_lambda_access_point,
    role_trust,
    dynamodb_table,

    pub const json_field_names = .{
        .s3_bucket = "S3_BUCKET",
        .s3_access_point = "S3_ACCESS_POINT",
        .s3_multi_region_access_point = "S3_MULTI_REGION_ACCESS_POINT",
        .s3_object_lambda_access_point = "S3_OBJECT_LAMBDA_ACCESS_POINT",
        .role_trust = "ROLE_TRUST",
        .dynamodb_table = "DYNAMODB_TABLE",
    };
};
