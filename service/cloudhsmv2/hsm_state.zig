const std = @import("std");

pub const HsmState = enum {
    create_in_progress,
    active,
    degraded,
    delete_in_progress,
    deleted,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .active = "ACTIVE",
        .degraded = "DEGRADED",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .deleted = "DELETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_in_progress => "CREATE_IN_PROGRESS",
            .active => "ACTIVE",
            .degraded => "DEGRADED",
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
