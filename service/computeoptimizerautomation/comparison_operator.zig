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
    string_equals_if_exists,
    string_not_equals_if_exists,
    string_equals_ignore_case_if_exists,
    string_not_equals_ignore_case_if_exists,
    string_like_if_exists,
    string_not_like_if_exists,
    numeric_equals_if_exists,
    numeric_not_equals_if_exists,
    numeric_less_than_if_exists,
    numeric_less_than_equals_if_exists,
    numeric_greater_than_if_exists,
    numeric_greater_than_equals_if_exists,

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
        .string_equals_if_exists = "StringEqualsIfExists",
        .string_not_equals_if_exists = "StringNotEqualsIfExists",
        .string_equals_ignore_case_if_exists = "StringEqualsIgnoreCaseIfExists",
        .string_not_equals_ignore_case_if_exists = "StringNotEqualsIgnoreCaseIfExists",
        .string_like_if_exists = "StringLikeIfExists",
        .string_not_like_if_exists = "StringNotLikeIfExists",
        .numeric_equals_if_exists = "NumericEqualsIfExists",
        .numeric_not_equals_if_exists = "NumericNotEqualsIfExists",
        .numeric_less_than_if_exists = "NumericLessThanIfExists",
        .numeric_less_than_equals_if_exists = "NumericLessThanEqualsIfExists",
        .numeric_greater_than_if_exists = "NumericGreaterThanIfExists",
        .numeric_greater_than_equals_if_exists = "NumericGreaterThanEqualsIfExists",
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
            .string_equals_if_exists => "StringEqualsIfExists",
            .string_not_equals_if_exists => "StringNotEqualsIfExists",
            .string_equals_ignore_case_if_exists => "StringEqualsIgnoreCaseIfExists",
            .string_not_equals_ignore_case_if_exists => "StringNotEqualsIgnoreCaseIfExists",
            .string_like_if_exists => "StringLikeIfExists",
            .string_not_like_if_exists => "StringNotLikeIfExists",
            .numeric_equals_if_exists => "NumericEqualsIfExists",
            .numeric_not_equals_if_exists => "NumericNotEqualsIfExists",
            .numeric_less_than_if_exists => "NumericLessThanIfExists",
            .numeric_less_than_equals_if_exists => "NumericLessThanEqualsIfExists",
            .numeric_greater_than_if_exists => "NumericGreaterThanIfExists",
            .numeric_greater_than_equals_if_exists => "NumericGreaterThanEqualsIfExists",
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
