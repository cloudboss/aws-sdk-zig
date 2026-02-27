pub const ContentDataSourceType = enum {
    custom,
    s3,

    pub const json_field_names = .{
        .custom = "CUSTOM",
        .s3 = "S3",
    };
};
