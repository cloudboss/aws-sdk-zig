const std = @import("std");

pub const MediaPipelineStatus = enum {
    initializing,
    in_progress,
    failed,
    stopping,
    stopped,
    paused,
    not_started,

    pub const json_field_names = .{
        .initializing = "Initializing",
        .in_progress = "InProgress",
        .failed = "Failed",
        .stopping = "Stopping",
        .stopped = "Stopped",
        .paused = "Paused",
        .not_started = "NotStarted",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initializing => "Initializing",
            .in_progress => "InProgress",
            .failed => "Failed",
            .stopping => "Stopping",
            .stopped => "Stopped",
            .paused => "Paused",
            .not_started => "NotStarted",
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
