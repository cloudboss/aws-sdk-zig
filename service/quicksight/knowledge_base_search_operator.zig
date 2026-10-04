const std = @import("std");

pub const KnowledgeBaseSearchOperator = enum {
    string_equals,
    string_like,
    greater_than_or_equals,
    less_than_or_equals,

    pub const json_field_names = .{
        .string_equals = "STRING_EQUALS",
        .string_like = "STRING_LIKE",
        .greater_than_or_equals = "GREATER_THAN_OR_EQUALS",
        .less_than_or_equals = "LESS_THAN_OR_EQUALS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .string_equals => "STRING_EQUALS",
            .string_like => "STRING_LIKE",
            .greater_than_or_equals => "GREATER_THAN_OR_EQUALS",
            .less_than_or_equals => "LESS_THAN_OR_EQUALS",
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
