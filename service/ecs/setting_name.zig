pub const SettingName = enum {
    service_long_arn_format,
    task_long_arn_format,
    container_instance_long_arn_format,
    awsvpc_trunking,
    container_insights,
    fargate_fips_mode,
    tag_resource_authorization,
    fargate_task_retirement_wait_period,
    guard_duty_activate,
    default_log_driver_mode,
    fargate_event_windows,

    pub const json_field_names = .{
        .service_long_arn_format = "SERVICE_LONG_ARN_FORMAT",
        .task_long_arn_format = "TASK_LONG_ARN_FORMAT",
        .container_instance_long_arn_format = "CONTAINER_INSTANCE_LONG_ARN_FORMAT",
        .awsvpc_trunking = "AWSVPC_TRUNKING",
        .container_insights = "CONTAINER_INSIGHTS",
        .fargate_fips_mode = "FARGATE_FIPS_MODE",
        .tag_resource_authorization = "TAG_RESOURCE_AUTHORIZATION",
        .fargate_task_retirement_wait_period = "FARGATE_TASK_RETIREMENT_WAIT_PERIOD",
        .guard_duty_activate = "GUARD_DUTY_ACTIVATE",
        .default_log_driver_mode = "DEFAULT_LOG_DRIVER_MODE",
        .fargate_event_windows = "FARGATE_EVENT_WINDOWS",
    };
};
