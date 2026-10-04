const std = @import("std");

pub const SearchFilterOperator = enum {
    equals,
    greater_than,
    greater_than_or_equals,
    less_than,
    less_than_or_equals,
    not_exists,

    pub const json_field_names = .{
        .equals = "equals",
        .greater_than = "greaterThan",
        .greater_than_or_equals = "greaterThanOrEquals",
        .less_than = "lessThan",
        .less_than_or_equals = "lessThanOrEquals",
        .not_exists = "notExists",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equals => "equals",
            .greater_than => "greaterThan",
            .greater_than_or_equals => "greaterThanOrEquals",
            .less_than => "lessThan",
            .less_than_or_equals => "lessThanOrEquals",
            .not_exists => "notExists",
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
