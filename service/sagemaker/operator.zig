const std = @import("std");

pub const Operator = enum {
    equals,
    not_equals,
    greater_than,
    greater_than_or_equal_to,
    less_than,
    less_than_or_equal_to,
    contains,
    exists,
    not_exists,
    in,

    pub const json_field_names = .{
        .equals = "Equals",
        .not_equals = "NotEquals",
        .greater_than = "GreaterThan",
        .greater_than_or_equal_to = "GreaterThanOrEqualTo",
        .less_than = "LessThan",
        .less_than_or_equal_to = "LessThanOrEqualTo",
        .contains = "Contains",
        .exists = "Exists",
        .not_exists = "NotExists",
        .in = "In",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equals => "Equals",
            .not_equals => "NotEquals",
            .greater_than => "GreaterThan",
            .greater_than_or_equal_to => "GreaterThanOrEqualTo",
            .less_than => "LessThan",
            .less_than_or_equal_to => "LessThanOrEqualTo",
            .contains => "Contains",
            .exists => "Exists",
            .not_exists => "NotExists",
            .in => "In",
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
