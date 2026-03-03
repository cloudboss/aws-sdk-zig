const std = @import("std");

pub const RetrievalResultContentType = enum {
    text,
    image,
    row,
    audio,
    video,

    pub const json_field_names = .{
        .text = "TEXT",
        .image = "IMAGE",
        .row = "ROW",
        .audio = "AUDIO",
        .video = "VIDEO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .text => "TEXT",
            .image => "IMAGE",
            .row => "ROW",
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
