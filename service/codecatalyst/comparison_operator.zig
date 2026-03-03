const std = @import("std");

pub const ComparisonOperator = enum {
    equals,
    greater_than,
    greater_than_or_equals,
    less_than,
    less_than_or_equals,
    begins_with,

    pub const json_field_names = .{
        .equals = "EQ",
        .greater_than = "GT",
        .greater_than_or_equals = "GE",
        .less_than = "LT",
        .less_than_or_equals = "LE",
        .begins_with = "BEGINS_WITH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equals => "EQ",
            .greater_than => "GT",
            .greater_than_or_equals => "GE",
            .less_than => "LT",
            .less_than_or_equals => "LE",
            .begins_with => "BEGINS_WITH",
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
