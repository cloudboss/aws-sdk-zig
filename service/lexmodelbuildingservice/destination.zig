pub const Destination = enum {
    cloudwatch_logs,
    s3,

    pub const json_field_names = .{
        .cloudwatch_logs = "CLOUDWATCH_LOGS",
        .s3 = "S3",
    };
};
