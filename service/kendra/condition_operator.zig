const std = @import("std");

pub const ConditionOperator = enum {
    greater_than,
    greater_than_or_equals,
    less_than,
    less_than_or_equals,
    equals,
    not_equals,
    contains,
    not_contains,
    exists,
    not_exists,
    begins_with,

    pub const json_field_names = .{
        .greater_than = "GreaterThan",
        .greater_than_or_equals = "GreaterThanOrEquals",
        .less_than = "LessThan",
        .less_than_or_equals = "LessThanOrEquals",
        .equals = "Equals",
        .not_equals = "NotEquals",
        .contains = "Contains",
        .not_contains = "NotContains",
        .exists = "Exists",
        .not_exists = "NotExists",
        .begins_with = "BeginsWith",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .greater_than => "GreaterThan",
            .greater_than_or_equals => "GreaterThanOrEquals",
            .less_than => "LessThan",
            .less_than_or_equals => "LessThanOrEquals",
            .equals => "Equals",
            .not_equals => "NotEquals",
            .contains => "Contains",
            .not_contains => "NotContains",
            .exists => "Exists",
            .not_exists => "NotExists",
            .begins_with => "BeginsWith",
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
