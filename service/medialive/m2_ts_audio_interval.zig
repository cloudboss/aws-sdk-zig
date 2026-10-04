const std = @import("std");

/// M2ts Audio Interval
pub const M2tsAudioInterval = enum {
    video_and_fixed_intervals,
    video_interval,

    pub const json_field_names = .{
        .video_and_fixed_intervals = "VIDEO_AND_FIXED_INTERVALS",
        .video_interval = "VIDEO_INTERVAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .video_and_fixed_intervals => "VIDEO_AND_FIXED_INTERVALS",
            .video_interval => "VIDEO_INTERVAL",
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
