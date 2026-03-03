const std = @import("std");

pub const ServiceStatus = enum {
    create_failed,
    running,
    deleted,
    delete_failed,
    paused,
    operation_in_progress,

    pub const json_field_names = .{
        .create_failed = "CREATE_FAILED",
        .running = "RUNNING",
        .deleted = "DELETED",
        .delete_failed = "DELETE_FAILED",
        .paused = "PAUSED",
        .operation_in_progress = "OPERATION_IN_PROGRESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_failed => "CREATE_FAILED",
            .running => "RUNNING",
            .deleted => "DELETED",
            .delete_failed => "DELETE_FAILED",
            .paused => "PAUSED",
            .operation_in_progress => "OPERATION_IN_PROGRESS",
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
