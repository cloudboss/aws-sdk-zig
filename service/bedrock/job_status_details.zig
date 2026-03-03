const std = @import("std");

pub const JobStatusDetails = enum {
    in_progress,
    completed,
    stopping,
    stopped,
    failed,
    not_started,

    pub const json_field_names = .{
        .in_progress = "InProgress",
        .completed = "Completed",
        .stopping = "Stopping",
        .stopped = "Stopped",
        .failed = "Failed",
        .not_started = "NotStarted",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "InProgress",
            .completed => "Completed",
            .stopping => "Stopping",
            .stopped => "Stopped",
            .failed => "Failed",
            .not_started => "NotStarted",
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
