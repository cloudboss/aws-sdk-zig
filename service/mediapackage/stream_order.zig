const std = @import("std");

pub const StreamOrder = enum {
    original,
    video_bitrate_ascending,
    video_bitrate_descending,

    pub const json_field_names = .{
        .original = "ORIGINAL",
        .video_bitrate_ascending = "VIDEO_BITRATE_ASCENDING",
        .video_bitrate_descending = "VIDEO_BITRATE_DESCENDING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .original => "ORIGINAL",
            .video_bitrate_ascending => "VIDEO_BITRATE_ASCENDING",
            .video_bitrate_descending => "VIDEO_BITRATE_DESCENDING",
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
