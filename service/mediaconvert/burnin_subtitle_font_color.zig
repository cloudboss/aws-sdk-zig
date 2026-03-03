const std = @import("std");

/// Specify the color of the burned-in captions text. Leave Font color blank and
/// set Style passthrough to enabled to use the font color data from your input
/// captions, if present.
pub const BurninSubtitleFontColor = enum {
    white,
    black,
    yellow,
    red,
    green,
    blue,
    hex,
    auto,

    pub const json_field_names = .{
        .white = "WHITE",
        .black = "BLACK",
        .yellow = "YELLOW",
        .red = "RED",
        .green = "GREEN",
        .blue = "BLUE",
        .hex = "HEX",
        .auto = "AUTO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .white => "WHITE",
            .black => "BLACK",
            .yellow => "YELLOW",
            .red => "RED",
            .green => "GREEN",
            .blue => "BLUE",
            .hex => "HEX",
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
