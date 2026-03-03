const std = @import("std");

pub const StackRefactorExecutionStatus = enum {
    unavailable,
    available,
    obsolete,
    execute_in_progress,
    execute_complete,
    execute_failed,
    rollback_in_progress,
    rollback_complete,
    rollback_failed,

    pub const json_field_names = .{
        .unavailable = "UNAVAILABLE",
        .available = "AVAILABLE",
        .obsolete = "OBSOLETE",
        .execute_in_progress = "EXECUTE_IN_PROGRESS",
        .execute_complete = "EXECUTE_COMPLETE",
        .execute_failed = "EXECUTE_FAILED",
        .rollback_in_progress = "ROLLBACK_IN_PROGRESS",
        .rollback_complete = "ROLLBACK_COMPLETE",
        .rollback_failed = "ROLLBACK_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unavailable => "UNAVAILABLE",
            .available => "AVAILABLE",
            .obsolete => "OBSOLETE",
            .execute_in_progress => "EXECUTE_IN_PROGRESS",
            .execute_complete => "EXECUTE_COMPLETE",
            .execute_failed => "EXECUTE_FAILED",
            .rollback_in_progress => "ROLLBACK_IN_PROGRESS",
            .rollback_complete => "ROLLBACK_COMPLETE",
            .rollback_failed => "ROLLBACK_FAILED",
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
