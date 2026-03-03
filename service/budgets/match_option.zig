const std = @import("std");

pub const MatchOption = enum {
    equals,
    absent,
    starts_with,
    ends_with,
    contains,
    greater_than_or_equal,
    case_sensitive,
    case_insensitive,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .absent = "ABSENT",
        .starts_with = "STARTS_WITH",
        .ends_with = "ENDS_WITH",
        .contains = "CONTAINS",
        .greater_than_or_equal = "GREATER_THAN_OR_EQUAL",
        .case_sensitive = "CASE_SENSITIVE",
        .case_insensitive = "CASE_INSENSITIVE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equals => "EQUALS",
            .absent => "ABSENT",
            .starts_with => "STARTS_WITH",
            .ends_with => "ENDS_WITH",
            .contains => "CONTAINS",
            .greater_than_or_equal => "GREATER_THAN_OR_EQUAL",
            .case_sensitive => "CASE_SENSITIVE",
            .case_insensitive => "CASE_INSENSITIVE",
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
