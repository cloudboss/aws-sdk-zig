const std = @import("std");

pub const Condition = enum {
    equals,
    not_equals,
    less_than,
    greater_than,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .not_equals = "NOT_EQUALS",
        .less_than = "LESS_THAN",
        .greater_than = "GREATER_THAN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equals => "EQUALS",
            .not_equals => "NOT_EQUALS",
            .less_than => "LESS_THAN",
            .greater_than => "GREATER_THAN",
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
