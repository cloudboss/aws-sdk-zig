const std = @import("std");

pub const RuleType = enum {
    binary_length,
    number_comparison,
    string_from_set,
    string_length,

    pub const json_field_names = .{
        .binary_length = "BINARY_LENGTH",
        .number_comparison = "NUMBER_COMPARISON",
        .string_from_set = "STRING_FROM_SET",
        .string_length = "STRING_LENGTH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .binary_length => "BINARY_LENGTH",
            .number_comparison => "NUMBER_COMPARISON",
            .string_from_set => "STRING_FROM_SET",
            .string_length => "STRING_LENGTH",
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
