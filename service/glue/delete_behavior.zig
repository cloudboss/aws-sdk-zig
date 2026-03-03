const std = @import("std");

pub const DeleteBehavior = enum {
    log,
    delete_from_database,
    deprecate_in_database,

    pub const json_field_names = .{
        .log = "LOG",
        .delete_from_database = "DELETE_FROM_DATABASE",
        .deprecate_in_database = "DEPRECATE_IN_DATABASE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .log => "LOG",
            .delete_from_database => "DELETE_FROM_DATABASE",
            .deprecate_in_database => "DEPRECATE_IN_DATABASE",
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
