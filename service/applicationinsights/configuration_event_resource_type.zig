pub const ConfigurationEventResourceType = enum {
    cloudwatch_alarm,
    cloudwatch_log,
    cloudformation,
    ssm_association,

    pub const json_field_names = .{
        .cloudwatch_alarm = "CLOUDWATCH_ALARM",
        .cloudwatch_log = "CLOUDWATCH_LOG",
        .cloudformation = "CLOUDFORMATION",
        .ssm_association = "SSM_ASSOCIATION",
    };
};
