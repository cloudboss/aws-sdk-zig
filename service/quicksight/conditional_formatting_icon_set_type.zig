const std = @import("std");

pub const ConditionalFormattingIconSetType = enum {
    plus_minus,
    check_x,
    three_color_arrow,
    three_gray_arrow,
    caret_up_minus_down,
    three_shape,
    three_circle,
    flags,
    bars,
    four_color_arrow,
    four_gray_arrow,

    pub const json_field_names = .{
        .plus_minus = "PLUS_MINUS",
        .check_x = "CHECK_X",
        .three_color_arrow = "THREE_COLOR_ARROW",
        .three_gray_arrow = "THREE_GRAY_ARROW",
        .caret_up_minus_down = "CARET_UP_MINUS_DOWN",
        .three_shape = "THREE_SHAPE",
        .three_circle = "THREE_CIRCLE",
        .flags = "FLAGS",
        .bars = "BARS",
        .four_color_arrow = "FOUR_COLOR_ARROW",
        .four_gray_arrow = "FOUR_GRAY_ARROW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .plus_minus => "PLUS_MINUS",
            .check_x => "CHECK_X",
            .three_color_arrow => "THREE_COLOR_ARROW",
            .three_gray_arrow => "THREE_GRAY_ARROW",
            .caret_up_minus_down => "CARET_UP_MINUS_DOWN",
            .three_shape => "THREE_SHAPE",
            .three_circle => "THREE_CIRCLE",
            .flags => "FLAGS",
            .bars => "BARS",
            .four_color_arrow => "FOUR_COLOR_ARROW",
            .four_gray_arrow => "FOUR_GRAY_ARROW",
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
