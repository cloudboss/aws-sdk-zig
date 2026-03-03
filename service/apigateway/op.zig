const std = @import("std");

pub const Op = enum {
    add,
    remove,
    replace,
    move,
    copy,
    @"test",

    pub const json_field_names = .{
        .add = "add",
        .remove = "remove",
        .replace = "replace",
        .move = "move",
        .copy = "copy",
        .@"test" = "test",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .add => "add",
            .remove => "remove",
            .replace => "replace",
            .move => "move",
            .copy => "copy",
            .@"test" => "test",
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
