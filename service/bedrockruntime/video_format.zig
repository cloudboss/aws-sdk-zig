const std = @import("std");

pub const VideoFormat = enum {
    mkv,
    mov,
    mp4,
    webm,
    flv,
    mpeg,
    mpg,
    wmv,
    three_gp,

    pub const json_field_names = .{
        .mkv = "mkv",
        .mov = "mov",
        .mp4 = "mp4",
        .webm = "webm",
        .flv = "flv",
        .mpeg = "mpeg",
        .mpg = "mpg",
        .wmv = "wmv",
        .three_gp = "three_gp",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .mkv => "mkv",
            .mov => "mov",
            .mp4 => "mp4",
            .webm => "webm",
            .flv => "flv",
            .mpeg => "mpeg",
            .mpg => "mpg",
            .wmv => "wmv",
            .three_gp => "three_gp",
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
