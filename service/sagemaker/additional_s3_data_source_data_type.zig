pub const AdditionalS3DataSourceDataType = enum {
    s3_object,
    s3_prefix,

    pub const json_field_names = .{
        .s3_object = "S3OBJECT",
        .s3_prefix = "S3PREFIX",
    };
};
