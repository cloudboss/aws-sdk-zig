const std = @import("std");

pub const MediaPipelineElementStatus = enum {
    not_started,
    not_supported,
    initializing,
    in_progress,
    failed,
    stopping,
    stopped,
    paused,

    pub const json_field_names = .{
        .not_started = "NotStarted",
        .not_supported = "NotSupported",
        .initializing = "Initializing",
        .in_progress = "InProgress",
        .failed = "Failed",
        .stopping = "Stopping",
        .stopped = "Stopped",
        .paused = "Paused",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_started => "NotStarted",
            .not_supported => "NotSupported",
            .initializing => "Initializing",
            .in_progress => "InProgress",
            .failed => "Failed",
            .stopping => "Stopping",
            .stopped => "Stopped",
            .paused => "Paused",
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
