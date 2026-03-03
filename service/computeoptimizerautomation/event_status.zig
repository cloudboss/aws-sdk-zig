const std = @import("std");

pub const EventStatus = enum {
    ready,
    in_progress,
    complete,
    failed,
    cancelled,
    rollback_ready,
    rollback_in_progress,
    rollback_complete,
    rollback_failed,

    pub const json_field_names = .{
        .ready = "Ready",
        .in_progress = "InProgress",
        .complete = "Complete",
        .failed = "Failed",
        .cancelled = "Cancelled",
        .rollback_ready = "RollbackReady",
        .rollback_in_progress = "RollbackInProgress",
        .rollback_complete = "RollbackComplete",
        .rollback_failed = "RollbackFailed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ready => "Ready",
            .in_progress => "InProgress",
            .complete => "Complete",
            .failed => "Failed",
            .cancelled => "Cancelled",
            .rollback_ready => "RollbackReady",
            .rollback_in_progress => "RollbackInProgress",
            .rollback_complete => "RollbackComplete",
            .rollback_failed => "RollbackFailed",
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
