const std = @import("std");

/// Specify whether your video overlay repeats or plays only once. To repeat
/// your video overlay on a loop: Keep the default value, Repeat. Your overlay
/// will repeat for the duration of the base input video. To playback your video
/// overlay only once: Choose Once. With either option, you can end playback at
/// a time that you specify by entering a value for End timecode.
pub const VideoOverlayPlayBackMode = enum {
    once,
    repeat,

    pub const json_field_names = .{
        .once = "ONCE",
        .repeat = "REPEAT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .once => "ONCE",
            .repeat => "REPEAT",
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
