const std = @import("std");

/// Specify font outline color. Leave Outline color blank and set Style
/// passthrough to enabled to use the font outline color data from your input
/// captions, if present.
pub const BurninSubtitleOutlineColor = enum {
    black,
    white,
    yellow,
    red,
    green,
    blue,
    auto,

    pub const json_field_names = .{
        .black = "BLACK",
        .white = "WHITE",
        .yellow = "YELLOW",
        .red = "RED",
        .green = "GREEN",
        .blue = "BLUE",
        .auto = "AUTO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .black => "BLACK",
            .white => "WHITE",
            .yellow => "YELLOW",
            .red => "RED",
            .green => "GREEN",
            .blue => "BLUE",
            .auto => "AUTO",
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
