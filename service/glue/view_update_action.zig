const std = @import("std");

pub const ViewUpdateAction = enum {
    add,
    replace,
    add_or_replace,
    drop,

    pub const json_field_names = .{
        .add = "ADD",
        .replace = "REPLACE",
        .add_or_replace = "ADD_OR_REPLACE",
        .drop = "DROP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .add => "ADD",
            .replace => "REPLACE",
            .add_or_replace => "ADD_OR_REPLACE",
            .drop => "DROP",
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
