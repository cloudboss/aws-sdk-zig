const std = @import("std");

pub const DifferenceType = enum {
    add,
    remove,
    not_equal,

    pub const json_field_names = .{
        .add = "ADD",
        .remove = "REMOVE",
        .not_equal = "NOT_EQUAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .add => "ADD",
            .remove => "REMOVE",
            .not_equal => "NOT_EQUAL",
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
