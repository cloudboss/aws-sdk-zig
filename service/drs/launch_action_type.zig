pub const LaunchActionType = enum {
    ssm_automation,
    ssm_command,

    pub const json_field_names = .{
        .ssm_automation = "SSM_AUTOMATION",
        .ssm_command = "SSM_COMMAND",
    };
};
