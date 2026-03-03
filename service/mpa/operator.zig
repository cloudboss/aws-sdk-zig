const std = @import("std");

pub const Operator = enum {
    equals,
    not_equals,
    greater_than,
    less_than,
    greater_than_or_equal_to,
    less_than_or_equal_to,
    contains,
    does_not_contain,
    between,

    pub const json_field_names = .{
        .equals = "EQ",
        .not_equals = "NE",
        .greater_than = "GT",
        .less_than = "LT",
        .greater_than_or_equal_to = "GTE",
        .less_than_or_equal_to = "LTE",
        .contains = "CONTAINS",
        .does_not_contain = "NOT_CONTAINS",
        .between = "BETWEEN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equals => "EQ",
            .not_equals => "NE",
            .greater_than => "GT",
            .less_than => "LT",
            .greater_than_or_equal_to => "GTE",
            .less_than_or_equal_to => "LTE",
            .contains => "CONTAINS",
            .does_not_contain => "NOT_CONTAINS",
            .between => "BETWEEN",
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
