const std = @import("std");

/// Execution status of a task.
pub const TaskExecutionStatus = enum {
    /// Task is currently running.
    in_progress,
    /// Task was aborted.
    aborted,
    /// Task completed successfully.
    completed,
    /// Task failed due to an internal error.
    internal_error,
    /// Task failed during execution.
    failed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .aborted = "ABORTED",
        .completed = "COMPLETED",
        .internal_error = "INTERNAL_ERROR",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "IN_PROGRESS",
            .aborted => "ABORTED",
            .completed => "COMPLETED",
            .internal_error => "INTERNAL_ERROR",
            .failed => "FAILED",
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
