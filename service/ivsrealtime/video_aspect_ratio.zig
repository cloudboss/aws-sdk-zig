const std = @import("std");

pub const VideoAspectRatio = enum {
    auto,
    video,
    square,
    portrait,

    pub const json_field_names = .{
        .auto = "AUTO",
        .video = "VIDEO",
        .square = "SQUARE",
        .portrait = "PORTRAIT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .auto => "AUTO",
            .video => "VIDEO",
            .square => "SQUARE",
            .portrait => "PORTRAIT",
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
