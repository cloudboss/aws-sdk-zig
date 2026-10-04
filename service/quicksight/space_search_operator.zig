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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
