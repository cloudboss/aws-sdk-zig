const std = @import("std");

pub const ActivityTaskTimeoutType = enum {
    start_to_close,
    schedule_to_start,
    schedule_to_close,
    heartbeat,

    pub const json_field_names = .{
        .start_to_close = "START_TO_CLOSE",
        .schedule_to_start = "SCHEDULE_TO_START",
        .schedule_to_close = "SCHEDULE_TO_CLOSE",
        .heartbeat = "HEARTBEAT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .start_to_close => "START_TO_CLOSE",
            .schedule_to_start => "SCHEDULE_TO_START",
            .schedule_to_close => "SCHEDULE_TO_CLOSE",
            .heartbeat => "HEARTBEAT",
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
