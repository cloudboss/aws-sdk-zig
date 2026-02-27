pub const SourceType = enum {
    aws_cloudtrail,
    aws_config,
    aws_security_hub,
    aws_api_call,
    manual,
    common_control,
    core_control,

    pub const json_field_names = .{
        .aws_cloudtrail = "AWS_CLOUDTRAIL",
        .aws_config = "AWS_CONFIG",
        .aws_security_hub = "AWS_SECURITY_HUB",
        .aws_api_call = "AWS_API_CALL",
        .manual = "MANUAL",
        .common_control = "COMMON_CONTROL",
        .core_control = "CORE_CONTROL",
    };
};
