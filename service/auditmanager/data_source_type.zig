pub const DataSourceType = enum {
    aws_cloudtrail,
    aws_config,
    aws_security_hub,
    aws_api_call,
    manual,

    pub const json_field_names = .{
        .aws_cloudtrail = "AWS_CLOUDTRAIL",
        .aws_config = "AWS_CONFIG",
        .aws_security_hub = "AWS_SECURITY_HUB",
        .aws_api_call = "AWS_API_CALL",
        .manual = "MANUAL",
    };
};
