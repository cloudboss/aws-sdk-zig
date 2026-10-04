const std = @import("std");

pub const MediaPipelineTaskStatus = enum {
    not_started,
    initializing,
    in_progress,
    failed,
    stopping,
    stopped,

    pub const json_field_names = .{
        .not_started = "NotStarted",
        .initializing = "Initializing",
        .in_progress = "InProgress",
        .failed = "Failed",
        .stopping = "Stopping",
        .stopped = "Stopped",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_started => "NotStarted",
            .initializing => "Initializing",
            .in_progress => "InProgress",
            .failed => "Failed",
            .stopping => "Stopping",
            .stopped => "Stopped",
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
