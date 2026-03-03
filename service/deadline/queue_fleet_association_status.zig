const std = @import("std");

pub const QueueFleetAssociationStatus = enum {
    active,
    stop_scheduling_and_complete_tasks,
    stop_scheduling_and_cancel_tasks,
    stopped,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .stop_scheduling_and_complete_tasks = "STOP_SCHEDULING_AND_COMPLETE_TASKS",
        .stop_scheduling_and_cancel_tasks = "STOP_SCHEDULING_AND_CANCEL_TASKS",
        .stopped = "STOPPED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .stop_scheduling_and_complete_tasks => "STOP_SCHEDULING_AND_COMPLETE_TASKS",
            .stop_scheduling_and_cancel_tasks => "STOP_SCHEDULING_AND_CANCEL_TASKS",
            .stopped => "STOPPED",
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
