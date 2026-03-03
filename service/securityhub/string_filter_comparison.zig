const std = @import("std");

pub const StringFilterComparison = enum {
    equals,
    prefix,
    not_equals,
    prefix_not_equals,
    contains,
    not_contains,
    contains_word,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .prefix = "PREFIX",
        .not_equals = "NOT_EQUALS",
        .prefix_not_equals = "PREFIX_NOT_EQUALS",
        .contains = "CONTAINS",
        .not_contains = "NOT_CONTAINS",
        .contains_word = "CONTAINS_WORD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equals => "EQUALS",
            .prefix => "PREFIX",
            .not_equals => "NOT_EQUALS",
            .prefix_not_equals => "PREFIX_NOT_EQUALS",
            .contains => "CONTAINS",
            .not_contains => "NOT_CONTAINS",
            .contains_word => "CONTAINS_WORD",
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
