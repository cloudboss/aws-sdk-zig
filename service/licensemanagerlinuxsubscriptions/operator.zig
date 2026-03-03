const std = @import("std");

pub const Operator = enum {
    /// Equal operator
    equal,
    /// Not equal operator
    not_equal,
    /// Contains operator
    contains,

    pub const json_field_names = .{
        .equal = "Equal",
        .not_equal = "NotEqual",
        .contains = "Contains",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .equal => "Equal",
            .not_equal => "NotEqual",
            .contains => "Contains",
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
