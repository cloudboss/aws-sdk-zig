const std = @import("std");

pub const Comparator = enum {
    equals,
    greater_than,
    less_than,
    greater_than_equals,
    less_than_equals,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .greater_than = "GREATER_THAN",
        .less_than = "LESS_THAN",
        .greater_than_equals = "GREATER_THAN_EQUALS",
        .less_than_equals = "LESS_THAN_EQUALS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equals => "EQUALS",
            .greater_than => "GREATER_THAN",
            .less_than => "LESS_THAN",
            .greater_than_equals => "GREATER_THAN_EQUALS",
            .less_than_equals => "LESS_THAN_EQUALS",
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
