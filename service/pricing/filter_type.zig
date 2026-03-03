const std = @import("std");

pub const FilterType = enum {
    term_match,
    equals,
    contains,
    any_of,
    none_of,

    pub const json_field_names = .{
        .term_match = "TERM_MATCH",
        .equals = "EQUALS",
        .contains = "CONTAINS",
        .any_of = "ANY_OF",
        .none_of = "NONE_OF",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .term_match => "TERM_MATCH",
            .equals => "EQUALS",
            .contains => "CONTAINS",
            .any_of => "ANY_OF",
            .none_of => "NONE_OF",
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
