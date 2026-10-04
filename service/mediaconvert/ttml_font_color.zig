const std = @import("std");

/// Specify the font color for TTML captions output.
pub const TtmlFontColor = enum {
    white,
    black,
    yellow,
    red,
    green,
    blue,
    auto,

    pub const json_field_names = .{
        .white = "WHITE",
        .black = "BLACK",
        .yellow = "YELLOW",
        .red = "RED",
        .green = "GREEN",
        .blue = "BLUE",
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
