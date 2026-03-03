const std = @import("std");

pub const DataSetNumericComparisonFilterOperator = enum {
    equals,
    does_not_equal,
    greater_than,
    greater_than_or_equals_to,
    less_than,
    less_than_or_equals_to,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .does_not_equal = "DOES_NOT_EQUAL",
        .greater_than = "GREATER_THAN",
        .greater_than_or_equals_to = "GREATER_THAN_OR_EQUALS_TO",
        .less_than = "LESS_THAN",
        .less_than_or_equals_to = "LESS_THAN_OR_EQUALS_TO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equals => "EQUALS",
            .does_not_equal => "DOES_NOT_EQUAL",
            .greater_than => "GREATER_THAN",
            .greater_than_or_equals_to => "GREATER_THAN_OR_EQUALS_TO",
            .less_than => "LESS_THAN",
            .less_than_or_equals_to => "LESS_THAN_OR_EQUALS_TO",
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
