const std = @import("std");

pub const GameServerGroupDeleteOption = enum {
    safe_delete,
    force_delete,
    retain,

    pub const json_field_names = .{
        .safe_delete = "SAFE_DELETE",
        .force_delete = "FORCE_DELETE",
        .retain = "RETAIN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .safe_delete => "SAFE_DELETE",
            .force_delete => "FORCE_DELETE",
            .retain => "RETAIN",
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
