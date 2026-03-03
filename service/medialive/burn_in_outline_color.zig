const std = @import("std");

/// Burn In Outline Color
pub const BurnInOutlineColor = enum {
    black,
    blue,
    green,
    red,
    white,
    yellow,

    pub const json_field_names = .{
        .black = "BLACK",
        .blue = "BLUE",
        .green = "GREEN",
        .red = "RED",
        .white = "WHITE",
        .yellow = "YELLOW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .black => "BLACK",
            .blue => "BLUE",
            .green => "GREEN",
            .red => "RED",
            .white => "WHITE",
            .yellow => "YELLOW",
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
