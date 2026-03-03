const std = @import("std");

pub const ClaimMatchOperatorType = enum {
    equals,
    contains,
    contains_any,

    pub const json_field_names = .{
        .equals = "EQUALS",
        .contains = "CONTAINS",
        .contains_any = "CONTAINS_ANY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equals => "EQUALS",
            .contains => "CONTAINS",
            .contains_any => "CONTAINS_ANY",
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
