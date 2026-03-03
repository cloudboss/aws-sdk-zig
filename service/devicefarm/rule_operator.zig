const std = @import("std");

pub const RuleOperator = enum {
    equals,
    less_than,
    less_than_or_equals,
    greater_than,
    greater_than_or_equals,
    in,
    not_in,
    contains,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .less_than = "LESS_THAN",
        .less_than_or_equals = "LESS_THAN_OR_EQUALS",
        .greater_than = "GREATER_THAN",
        .greater_than_or_equals = "GREATER_THAN_OR_EQUALS",
        .in = "IN",
        .not_in = "NOT_IN",
        .contains = "CONTAINS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equals => "EQUALS",
            .less_than => "LESS_THAN",
            .less_than_or_equals => "LESS_THAN_OR_EQUALS",
            .greater_than => "GREATER_THAN",
            .greater_than_or_equals => "GREATER_THAN_OR_EQUALS",
            .in => "IN",
            .not_in => "NOT_IN",
            .contains => "CONTAINS",
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
