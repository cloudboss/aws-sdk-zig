const std = @import("std");

pub const LongConditionOperator = enum {
    equals_to,
    not_equals_to,
    less_than_equal_to,
    greater_than_equal_to,

    pub const json_field_names = .{
        .equals_to = "EQUALS_TO",
        .not_equals_to = "NOT_EQUALS_TO",
        .less_than_equal_to = "LESS_THAN_EQUAL_TO",
        .greater_than_equal_to = "GREATER_THAN_EQUAL_TO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equals_to => "EQUALS_TO",
            .not_equals_to => "NOT_EQUALS_TO",
            .less_than_equal_to => "LESS_THAN_EQUAL_TO",
            .greater_than_equal_to => "GREATER_THAN_EQUAL_TO",
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
