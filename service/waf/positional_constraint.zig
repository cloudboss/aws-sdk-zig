const std = @import("std");

pub const PositionalConstraint = enum {
    exactly,
    starts_with,
    ends_with,
    contains,
    contains_word,

    pub const json_field_names = .{
        .exactly = "EXACTLY",
        .starts_with = "STARTS_WITH",
        .ends_with = "ENDS_WITH",
        .contains = "CONTAINS",
        .contains_word = "CONTAINS_WORD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .exactly => "EXACTLY",
            .starts_with => "STARTS_WITH",
            .ends_with => "ENDS_WITH",
            .contains => "CONTAINS",
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
