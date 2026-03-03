const std = @import("std");

pub const WorkflowExecutionStatus = enum {
    pending,
    skipped,
    running,
    completed,
    failed,
    rollback_in_progress,
    rollback_completed,
    cancelled,

    pub const json_field_names = .{
        .pending = "PENDING",
        .skipped = "SKIPPED",
        .running = "RUNNING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .rollback_in_progress = "ROLLBACK_IN_PROGRESS",
        .rollback_completed = "ROLLBACK_COMPLETED",
        .cancelled = "CANCELLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .skipped => "SKIPPED",
            .running => "RUNNING",
            .completed => "COMPLETED",
            .failed => "FAILED",
            .rollback_in_progress => "ROLLBACK_IN_PROGRESS",
            .rollback_completed => "ROLLBACK_COMPLETED",
            .cancelled => "CANCELLED",
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
