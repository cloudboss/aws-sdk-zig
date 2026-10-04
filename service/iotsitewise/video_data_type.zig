const std = @import("std");

/// The allowed video data types.
pub const VideoDataType = enum {
    mp4,

    pub const json_field_names = .{
        .mp4 = "VIDEO-MP4",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mp4 => "VIDEO-MP4",
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
