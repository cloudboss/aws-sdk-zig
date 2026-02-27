/// The fleet attribute.
pub const FleetAttribute = enum {
    vpc_configuration,
    vpc_configuration_security_group_ids,
    domain_join_info,
    iam_role_arn,
    usb_device_filter_strings,
    session_script_s3_location,
    max_sessions_per_instance,
    volume_configuration,

    pub const json_field_names = .{
        .vpc_configuration = "VPC_CONFIGURATION",
        .vpc_configuration_security_group_ids = "VPC_CONFIGURATION_SECURITY_GROUP_IDS",
        .domain_join_info = "DOMAIN_JOIN_INFO",
        .iam_role_arn = "IAM_ROLE_ARN",
        .usb_device_filter_strings = "USB_DEVICE_FILTER_STRINGS",
        .session_script_s3_location = "SESSION_SCRIPT_S3_LOCATION",
        .max_sessions_per_instance = "MAX_SESSIONS_PER_INSTANCE",
        .volume_configuration = "VOLUME_CONFIGURATION",
    };
};
