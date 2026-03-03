const std = @import("std");

pub const UpdateQueueLimitAssociationStatus = enum {
    active,
    stop_limit_usage_and_complete_tasks,
    stop_limit_usage_and_cancel_tasks,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .stop_limit_usage_and_complete_tasks = "STOP_LIMIT_USAGE_AND_COMPLETE_TASKS",
        .stop_limit_usage_and_cancel_tasks = "STOP_LIMIT_USAGE_AND_CANCEL_TASKS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .stop_limit_usage_and_complete_tasks => "STOP_LIMIT_USAGE_AND_COMPLETE_TASKS",
            .stop_limit_usage_and_cancel_tasks => "STOP_LIMIT_USAGE_AND_CANCEL_TASKS",
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
