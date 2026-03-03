const std = @import("std");

pub const AttributeChangeType = enum {
    add,
    remove,
    modify,
    sync_with_actual,

    pub const json_field_names = .{
        .add = "Add",
        .remove = "Remove",
        .modify = "Modify",
        .sync_with_actual = "SyncWithActual",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .add => "Add",
            .remove => "Remove",
            .modify => "Modify",
            .sync_with_actual => "SyncWithActual",
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
