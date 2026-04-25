const std = @import("std");

pub const DaemonTaskDefinitionStatus = enum {
    active,
    delete_in_progress,
    deleted,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .delete_in_progress => "DELETE_IN_PROGRESS",
            .deleted => "DELETED",
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
