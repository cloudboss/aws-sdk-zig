const std = @import("std");

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
        .service_long_arn_format = "serviceLongArnFormat",
        .task_long_arn_format = "taskLongArnFormat",
        .container_instance_long_arn_format = "containerInstanceLongArnFormat",
        .awsvpc_trunking = "awsvpcTrunking",
        .container_insights = "containerInsights",
        .fargate_fips_mode = "fargateFIPSMode",
        .tag_resource_authorization = "tagResourceAuthorization",
        .fargate_task_retirement_wait_period = "fargateTaskRetirementWaitPeriod",
        .guard_duty_activate = "guardDutyActivate",
        .default_log_driver_mode = "defaultLogDriverMode",
        .fargate_event_windows = "fargateEventWindows",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .service_long_arn_format => "serviceLongArnFormat",
            .task_long_arn_format => "taskLongArnFormat",
            .container_instance_long_arn_format => "containerInstanceLongArnFormat",
            .awsvpc_trunking => "awsvpcTrunking",
            .container_insights => "containerInsights",
            .fargate_fips_mode => "fargateFIPSMode",
            .tag_resource_authorization => "tagResourceAuthorization",
            .fargate_task_retirement_wait_period => "fargateTaskRetirementWaitPeriod",
            .guard_duty_activate => "guardDutyActivate",
            .default_log_driver_mode => "defaultLogDriverMode",
            .fargate_event_windows => "fargateEventWindows",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
