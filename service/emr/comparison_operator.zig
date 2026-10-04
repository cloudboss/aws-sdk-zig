const std = @import("std");

pub const ComparisonOperator = enum {
    greater_than_or_equal,
    greater_than,
    less_than,
    less_than_or_equal,

    pub const json_field_names = .{
        .greater_than_or_equal = "GREATER_THAN_OR_EQUAL",
        .greater_than = "GREATER_THAN",
        .less_than = "LESS_THAN",
        .less_than_or_equal = "LESS_THAN_OR_EQUAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .greater_than_or_equal => "GREATER_THAN_OR_EQUAL",
            .greater_than => "GREATER_THAN",
            .less_than => "LESS_THAN",
            .less_than_or_equal => "LESS_THAN_OR_EQUAL",
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
