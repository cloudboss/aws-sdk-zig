const std = @import("std");

pub const DecimalComparisonType = enum {
    greater_or_equal,
    greater,
    lesser_or_equal,
    lesser,
    equal,
    not_equal,
    range,

    pub const json_field_names = .{
        .greater_or_equal = "GREATER_OR_EQUAL",
        .greater = "GREATER",
        .lesser_or_equal = "LESSER_OR_EQUAL",
        .lesser = "LESSER",
        .equal = "EQUAL",
        .not_equal = "NOT_EQUAL",
        .range = "RANGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .greater_or_equal => "GREATER_OR_EQUAL",
            .greater => "GREATER",
            .lesser_or_equal => "LESSER_OR_EQUAL",
            .lesser => "LESSER",
            .equal => "EQUAL",
            .not_equal => "NOT_EQUAL",
            .range => "RANGE",
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
