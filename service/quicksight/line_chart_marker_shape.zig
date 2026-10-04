const std = @import("std");

pub const LineChartMarkerShape = enum {
    circle,
    triangle,
    square,
    diamond,
    rounded_square,

    pub const json_field_names = .{
        .circle = "CIRCLE",
        .triangle = "TRIANGLE",
        .square = "SQUARE",
        .diamond = "DIAMOND",
        .rounded_square = "ROUNDED_SQUARE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .circle => "CIRCLE",
            .triangle => "TRIANGLE",
            .square => "SQUARE",
            .diamond => "DIAMOND",
            .rounded_square => "ROUNDED_SQUARE",
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
