const std = @import("std");

pub const ExecutionStatus = enum {
    unavailable,
    available,
    execute_in_progress,
    execute_complete,
    execute_failed,
    obsolete,

    pub const json_field_names = .{
        .unavailable = "UNAVAILABLE",
        .available = "AVAILABLE",
        .execute_in_progress = "EXECUTE_IN_PROGRESS",
        .execute_complete = "EXECUTE_COMPLETE",
        .execute_failed = "EXECUTE_FAILED",
        .obsolete = "OBSOLETE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unavailable => "UNAVAILABLE",
            .available => "AVAILABLE",
            .execute_in_progress => "EXECUTE_IN_PROGRESS",
            .execute_complete => "EXECUTE_COMPLETE",
            .execute_failed => "EXECUTE_FAILED",
            .obsolete => "OBSOLETE",
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
