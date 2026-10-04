const std = @import("std");

pub const SpaceSearchOperator = enum {
    string_equals,
    string_like,
    number_range,

    pub const json_field_names = .{
        .string_equals = "STRING_EQUALS",
        .string_like = "STRING_LIKE",
        .number_range = "NUMBER_RANGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .string_equals => "STRING_EQUALS",
            .string_like => "STRING_LIKE",
            .number_range => "NUMBER_RANGE",
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
