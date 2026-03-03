const std = @import("std");

/// Type
pub const Type = enum {
    document,
    image,
    audio,
    video,

    pub const json_field_names = .{
        .document = "DOCUMENT",
        .image = "IMAGE",
        .audio = "AUDIO",
        .video = "VIDEO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .document => "DOCUMENT",
            .image => "IMAGE",
            .audio => "AUDIO",
            .video => "VIDEO",
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
