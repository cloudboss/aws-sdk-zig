const std = @import("std");

pub const OperationType = enum {
    insert,
    modify,
    remove,

    pub const json_field_names = .{
        .insert = "INSERT",
        .modify = "MODIFY",
        .remove = "REMOVE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .insert => "INSERT",
            .modify => "MODIFY",
            .remove => "REMOVE",
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
