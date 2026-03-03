const std = @import("std");

pub const ScaleDownBehavior = enum {
    terminate_at_instance_hour,
    terminate_at_task_completion,

    pub const json_field_names = .{
        .terminate_at_instance_hour = "TERMINATE_AT_INSTANCE_HOUR",
        .terminate_at_task_completion = "TERMINATE_AT_TASK_COMPLETION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .terminate_at_instance_hour => "TERMINATE_AT_INSTANCE_HOUR",
            .terminate_at_task_completion => "TERMINATE_AT_TASK_COMPLETION",
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
