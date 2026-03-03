const std = @import("std");

pub const Operator = enum {
    equal_to,
    greater_than,
    less_than,
    not_equal_to,

    pub const json_field_names = .{
        .equal_to = "EQUAL_TO",
        .greater_than = "GREATER_THAN",
        .less_than = "LESS_THAN",
        .not_equal_to = "NOT_EQUAL_TO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equal_to => "EQUAL_TO",
            .greater_than => "GREATER_THAN",
            .less_than => "LESS_THAN",
            .not_equal_to => "NOT_EQUAL_TO",
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
