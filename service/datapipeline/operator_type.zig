const std = @import("std");

pub const OperatorType = enum {
    equal,
    reference_equal,
    less_than_or_equal,
    greater_than_or_equal,
    between,

    pub const json_field_names = .{
        .equal = "EQ",
        .reference_equal = "REF_EQ",
        .less_than_or_equal = "LE",
        .greater_than_or_equal = "GE",
        .between = "BETWEEN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equal => "EQ",
            .reference_equal => "REF_EQ",
            .less_than_or_equal => "LE",
            .greater_than_or_equal => "GE",
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
