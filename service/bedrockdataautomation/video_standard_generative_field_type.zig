const std = @import("std");

pub const VideoStandardGenerativeFieldType = enum {
    video_summary,
    iab,
    chapter_summary,

    pub const json_field_names = .{
        .video_summary = "VIDEO_SUMMARY",
        .iab = "IAB",
        .chapter_summary = "CHAPTER_SUMMARY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .video_summary => "VIDEO_SUMMARY",
            .iab => "IAB",
            .chapter_summary => "CHAPTER_SUMMARY",
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
