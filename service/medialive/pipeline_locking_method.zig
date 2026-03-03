const std = @import("std");

/// Pipeline Locking Method
pub const PipelineLockingMethod = enum {
    source_timecode,
    video_alignment,

    pub const json_field_names = .{
        .source_timecode = "SOURCE_TIMECODE",
        .video_alignment = "VIDEO_ALIGNMENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .source_timecode => "SOURCE_TIMECODE",
            .video_alignment => "VIDEO_ALIGNMENT",
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
