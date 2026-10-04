const std = @import("std");

pub const NetworkMigrationDeployedStackStatus = enum {
    create_complete,
    create_failed,
    create_started,
    delete_complete,
    delete_failed,
    delete_started,

    pub const json_field_names = .{
        .create_complete = "CREATE_COMPLETE",
        .create_failed = "CREATE_FAILED",
        .create_started = "CREATE_STARTED",
        .delete_complete = "DELETE_COMPLETE",
        .delete_failed = "DELETE_FAILED",
        .delete_started = "DELETE_STARTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_complete => "CREATE_COMPLETE",
            .create_failed => "CREATE_FAILED",
            .create_started => "CREATE_STARTED",
            .delete_complete => "DELETE_COMPLETE",
            .delete_failed => "DELETE_FAILED",
            .delete_started => "DELETE_STARTED",
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
