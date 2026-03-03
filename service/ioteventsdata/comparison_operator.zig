const std = @import("std");

pub const ComparisonOperator = enum {
    greater,
    greater_or_equal,
    less,
    less_or_equal,
    equal,
    not_equal,

    pub const json_field_names = .{
        .greater = "GREATER",
        .greater_or_equal = "GREATER_OR_EQUAL",
        .less = "LESS",
        .less_or_equal = "LESS_OR_EQUAL",
        .equal = "EQUAL",
        .not_equal = "NOT_EQUAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .greater => "GREATER",
            .greater_or_equal => "GREATER_OR_EQUAL",
            .less => "LESS",
            .less_or_equal => "LESS_OR_EQUAL",
            .equal => "EQUAL",
            .not_equal => "NOT_EQUAL",
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
