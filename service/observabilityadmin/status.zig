const std = @import("std");

pub const Status = enum {
    not_started,
    starting,
    failed_start,
    running,
    stopping,
    failed_stop,
    stopped,

    pub const json_field_names = .{
        .not_started = "NOT_STARTED",
        .starting = "STARTING",
        .failed_start = "FAILED_START",
        .running = "RUNNING",
        .stopping = "STOPPING",
        .failed_stop = "FAILED_STOP",
        .stopped = "STOPPED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_started => "NOT_STARTED",
            .starting => "STARTING",
            .failed_start => "FAILED_START",
            .running => "RUNNING",
            .stopping => "STOPPING",
            .failed_stop => "FAILED_STOP",
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
