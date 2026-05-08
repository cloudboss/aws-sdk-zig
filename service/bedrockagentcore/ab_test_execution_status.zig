const std = @import("std");

pub const ABTestExecutionStatus = enum {
    paused,
    running,
    stopped,
    not_started,

    pub const json_field_names = .{
        .paused = "PAUSED",
        .running = "RUNNING",
        .stopped = "STOPPED",
        .not_started = "NOT_STARTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .paused => "PAUSED",
            .running => "RUNNING",
            .stopped => "STOPPED",
            .not_started => "NOT_STARTED",
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
