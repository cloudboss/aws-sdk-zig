const std = @import("std");

pub const ServiceLevelIndicatorComparisonOperator = enum {
    greater_than_or_equal_to,
    greater_than,
    less_than,
    less_than_or_equal_to,

    pub const json_field_names = .{
        .greater_than_or_equal_to = "GreaterThanOrEqualTo",
        .greater_than = "GreaterThan",
        .less_than = "LessThan",
        .less_than_or_equal_to = "LessThanOrEqualTo",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .greater_than_or_equal_to => "GreaterThanOrEqualTo",
            .greater_than => "GreaterThan",
            .less_than => "LessThan",
            .less_than_or_equal_to => "LessThanOrEqualTo",
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
