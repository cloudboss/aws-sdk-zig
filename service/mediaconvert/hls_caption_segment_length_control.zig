const std = @import("std");

/// Set Caption segment length control to Match video to create caption segments
/// that align with the video segments from the first video output in this
/// output group. For example, if the video segments are 2 seconds long, your
/// WebVTT segments will also be 2 seconds long. Keep the default setting, Large
/// segments to create caption segments that are 300 seconds long.
pub const HlsCaptionSegmentLengthControl = enum {
    large_segments,
    match_video,

    pub const json_field_names = .{
        .large_segments = "LARGE_SEGMENTS",
        .match_video = "MATCH_VIDEO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .large_segments => "LARGE_SEGMENTS",
            .match_video => "MATCH_VIDEO",
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
