const std = @import("std");

pub const ConditionOperatorType = enum {
    equals,
    not_equals,
    greater_then,
    greater_or_equals,
    less_then,
    less_or_equals,

    pub const json_field_names = .{
        .equals = "Equals",
        .not_equals = "NotEquals",
        .greater_then = "GreaterThen",
        .greater_or_equals = "GreaterOrEquals",
        .less_then = "LessThen",
        .less_or_equals = "LessOrEquals",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equals => "Equals",
            .not_equals => "NotEquals",
            .greater_then => "GreaterThen",
            .greater_or_equals => "GreaterOrEquals",
            .less_then => "LessThen",
            .less_or_equals => "LessOrEquals",
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
