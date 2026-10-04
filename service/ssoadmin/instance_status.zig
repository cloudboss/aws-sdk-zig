const std = @import("std");

pub const InstanceStatus = enum {
    create_in_progress,
    create_failed,
    delete_in_progress,
    active,

    pub const json_field_names = .{
        .create_in_progress = "CREATE_IN_PROGRESS",
        .create_failed = "CREATE_FAILED",
        .delete_in_progress = "DELETE_IN_PROGRESS",
        .active = "ACTIVE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_in_progress => "CREATE_IN_PROGRESS",
            .create_failed => "CREATE_FAILED",
            .delete_in_progress => "DELETE_IN_PROGRESS",
            .active => "ACTIVE",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
