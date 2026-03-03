const std = @import("std");

pub const OpsItemFilterOperator = enum {
    equal,
    contains,
    greater_than,
    less_than,

    pub const json_field_names = .{
        .equal = "Equal",
        .contains = "Contains",
        .greater_than = "GreaterThan",
        .less_than = "LessThan",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equal => "Equal",
            .contains => "Contains",
            .greater_than => "GreaterThan",
            .less_than => "LessThan",
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
