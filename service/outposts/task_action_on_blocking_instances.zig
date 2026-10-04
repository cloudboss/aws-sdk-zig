const std = @import("std");

pub const TaskActionOnBlockingInstances = enum {
    wait_for_evacuation,
    fail_task,

    pub const json_field_names = .{
        .wait_for_evacuation = "WAIT_FOR_EVACUATION",
        .fail_task = "FAIL_TASK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .wait_for_evacuation => "WAIT_FOR_EVACUATION",
            .fail_task => "FAIL_TASK",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
