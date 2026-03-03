const std = @import("std");

pub const ScheduleActivityTaskFailedCause = enum {
    activity_type_deprecated,
    activity_type_does_not_exist,
    activity_id_already_in_use,
    open_activities_limit_exceeded,
    activity_creation_rate_exceeded,
    default_schedule_to_close_timeout_undefined,
    default_task_list_undefined,
    default_schedule_to_start_timeout_undefined,
    default_start_to_close_timeout_undefined,
    default_heartbeat_timeout_undefined,
    operation_not_permitted,

    pub const json_field_names = .{
        .activity_type_deprecated = "ACTIVITY_TYPE_DEPRECATED",
        .activity_type_does_not_exist = "ACTIVITY_TYPE_DOES_NOT_EXIST",
        .activity_id_already_in_use = "ACTIVITY_ID_ALREADY_IN_USE",
        .open_activities_limit_exceeded = "OPEN_ACTIVITIES_LIMIT_EXCEEDED",
        .activity_creation_rate_exceeded = "ACTIVITY_CREATION_RATE_EXCEEDED",
        .default_schedule_to_close_timeout_undefined = "DEFAULT_SCHEDULE_TO_CLOSE_TIMEOUT_UNDEFINED",
        .default_task_list_undefined = "DEFAULT_TASK_LIST_UNDEFINED",
        .default_schedule_to_start_timeout_undefined = "DEFAULT_SCHEDULE_TO_START_TIMEOUT_UNDEFINED",
        .default_start_to_close_timeout_undefined = "DEFAULT_START_TO_CLOSE_TIMEOUT_UNDEFINED",
        .default_heartbeat_timeout_undefined = "DEFAULT_HEARTBEAT_TIMEOUT_UNDEFINED",
        .operation_not_permitted = "OPERATION_NOT_PERMITTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .activity_type_deprecated => "ACTIVITY_TYPE_DEPRECATED",
            .activity_type_does_not_exist => "ACTIVITY_TYPE_DOES_NOT_EXIST",
            .activity_id_already_in_use => "ACTIVITY_ID_ALREADY_IN_USE",
            .open_activities_limit_exceeded => "OPEN_ACTIVITIES_LIMIT_EXCEEDED",
            .activity_creation_rate_exceeded => "ACTIVITY_CREATION_RATE_EXCEEDED",
            .default_schedule_to_close_timeout_undefined => "DEFAULT_SCHEDULE_TO_CLOSE_TIMEOUT_UNDEFINED",
            .default_task_list_undefined => "DEFAULT_TASK_LIST_UNDEFINED",
            .default_schedule_to_start_timeout_undefined => "DEFAULT_SCHEDULE_TO_START_TIMEOUT_UNDEFINED",
            .default_start_to_close_timeout_undefined => "DEFAULT_START_TO_CLOSE_TIMEOUT_UNDEFINED",
            .default_heartbeat_timeout_undefined => "DEFAULT_HEARTBEAT_TIMEOUT_UNDEFINED",
            .operation_not_permitted => "OPERATION_NOT_PERMITTED",
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
