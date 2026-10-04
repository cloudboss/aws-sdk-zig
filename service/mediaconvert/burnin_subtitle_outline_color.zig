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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
