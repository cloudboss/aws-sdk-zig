const std = @import("std");

pub const FilterOperator = enum {
    equals,
    not_equals,
    greater_than,
    less_than,
    greater_than_or_equal,
    less_than_or_equal,
    contains,
    not_contains,

    pub const json_field_names = .{
        .equals = "Equals",
        .not_equals = "NotEquals",
        .greater_than = "GreaterThan",
        .less_than = "LessThan",
        .greater_than_or_equal = "GreaterThanOrEqual",
        .less_than_or_equal = "LessThanOrEqual",
        .contains = "Contains",
        .not_contains = "NotContains",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equals => "Equals",
            .not_equals => "NotEquals",
            .greater_than => "GreaterThan",
            .less_than => "LessThan",
            .greater_than_or_equal => "GreaterThanOrEqual",
            .less_than_or_equal => "LessThanOrEqual",
            .contains => "Contains",
            .not_contains => "NotContains",
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
