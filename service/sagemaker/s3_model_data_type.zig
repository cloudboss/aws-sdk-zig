pub const S3ModelDataType = enum {
    s3_prefix,
    s3_object,

    pub const json_field_names = .{
        .s3_prefix = "S3Prefix",
        .s3_object = "S3Object",
    };
};
