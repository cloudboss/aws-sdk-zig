const std = @import("std");

pub const ComparisonOperator = enum {
    string_equals,
    string_not_equals,
    string_equals_ignore_case,
    string_not_equals_ignore_case,
    string_like,
    string_not_like,
    numeric_equals,
    numeric_not_equals,
    numeric_less_than,
    numeric_less_than_equals,
    numeric_greater_than,
    numeric_greater_than_equals,

    pub const json_field_names = .{
        .string_equals = "StringEquals",
        .string_not_equals = "StringNotEquals",
        .string_equals_ignore_case = "StringEqualsIgnoreCase",
        .string_not_equals_ignore_case = "StringNotEqualsIgnoreCase",
        .string_like = "StringLike",
        .string_not_like = "StringNotLike",
        .numeric_equals = "NumericEquals",
        .numeric_not_equals = "NumericNotEquals",
        .numeric_less_than = "NumericLessThan",
        .numeric_less_than_equals = "NumericLessThanEquals",
        .numeric_greater_than = "NumericGreaterThan",
        .numeric_greater_than_equals = "NumericGreaterThanEquals",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .string_equals => "StringEquals",
            .string_not_equals => "StringNotEquals",
            .string_equals_ignore_case => "StringEqualsIgnoreCase",
            .string_not_equals_ignore_case => "StringNotEqualsIgnoreCase",
            .string_like => "StringLike",
            .string_not_like => "StringNotLike",
            .numeric_equals => "NumericEquals",
            .numeric_not_equals => "NumericNotEquals",
            .numeric_less_than => "NumericLessThan",
            .numeric_less_than_equals => "NumericLessThanEquals",
            .numeric_greater_than => "NumericGreaterThan",
            .numeric_greater_than_equals => "NumericGreaterThanEquals",
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
