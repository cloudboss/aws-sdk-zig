const std = @import("std");

pub const DecalPatternType = enum {
    solid,
    diagonal_medium,
    circle_medium,
    diamond_grid_medium,
    checkerboard_medium,
    triangle_medium,
    diagonal_opposite_medium,
    diamond_medium,
    diagonal_large,
    circle_large,
    diamond_grid_large,
    checkerboard_large,
    triangle_large,
    diagonal_opposite_large,
    diamond_large,
    diagonal_small,
    circle_small,
    diamond_grid_small,
    checkerboard_small,
    triangle_small,
    diagonal_opposite_small,
    diamond_small,

    pub const json_field_names = .{
        .solid = "SOLID",
        .diagonal_medium = "DIAGONAL_MEDIUM",
        .circle_medium = "CIRCLE_MEDIUM",
        .diamond_grid_medium = "DIAMOND_GRID_MEDIUM",
        .checkerboard_medium = "CHECKERBOARD_MEDIUM",
        .triangle_medium = "TRIANGLE_MEDIUM",
        .diagonal_opposite_medium = "DIAGONAL_OPPOSITE_MEDIUM",
        .diamond_medium = "DIAMOND_MEDIUM",
        .diagonal_large = "DIAGONAL_LARGE",
        .circle_large = "CIRCLE_LARGE",
        .diamond_grid_large = "DIAMOND_GRID_LARGE",
        .checkerboard_large = "CHECKERBOARD_LARGE",
        .triangle_large = "TRIANGLE_LARGE",
        .diagonal_opposite_large = "DIAGONAL_OPPOSITE_LARGE",
        .diamond_large = "DIAMOND_LARGE",
        .diagonal_small = "DIAGONAL_SMALL",
        .circle_small = "CIRCLE_SMALL",
        .diamond_grid_small = "DIAMOND_GRID_SMALL",
        .checkerboard_small = "CHECKERBOARD_SMALL",
        .triangle_small = "TRIANGLE_SMALL",
        .diagonal_opposite_small = "DIAGONAL_OPPOSITE_SMALL",
        .diamond_small = "DIAMOND_SMALL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .solid => "SOLID",
            .diagonal_medium => "DIAGONAL_MEDIUM",
            .circle_medium => "CIRCLE_MEDIUM",
            .diamond_grid_medium => "DIAMOND_GRID_MEDIUM",
            .checkerboard_medium => "CHECKERBOARD_MEDIUM",
            .triangle_medium => "TRIANGLE_MEDIUM",
            .diagonal_opposite_medium => "DIAGONAL_OPPOSITE_MEDIUM",
            .diamond_medium => "DIAMOND_MEDIUM",
            .diagonal_large => "DIAGONAL_LARGE",
            .circle_large => "CIRCLE_LARGE",
            .diamond_grid_large => "DIAMOND_GRID_LARGE",
            .checkerboard_large => "CHECKERBOARD_LARGE",
            .triangle_large => "TRIANGLE_LARGE",
            .diagonal_opposite_large => "DIAGONAL_OPPOSITE_LARGE",
            .diamond_large => "DIAMOND_LARGE",
            .diagonal_small => "DIAGONAL_SMALL",
            .circle_small => "CIRCLE_SMALL",
            .diamond_grid_small => "DIAMOND_GRID_SMALL",
            .checkerboard_small => "CHECKERBOARD_SMALL",
            .triangle_small => "TRIANGLE_SMALL",
            .diagonal_opposite_small => "DIAGONAL_OPPOSITE_SMALL",
            .diamond_small => "DIAMOND_SMALL",
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
