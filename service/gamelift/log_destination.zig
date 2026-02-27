pub const LogDestination = enum {
    none,
    cloudwatch,
    s3,

    pub const json_field_names = .{
        .none = "NONE",
        .cloudwatch = "CLOUDWATCH",
        .s3 = "S3",
    };
};
