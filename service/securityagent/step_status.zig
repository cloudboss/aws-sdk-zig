const std = @import("std");

/// Pentest job step status.
pub const StepStatus = enum {
    /// Step has not started yet.
    not_started,
    /// Step is currently running.
    in_progress,
    /// Step completed successfully.
    completed,
    /// Step failed during execution.
    failed,
    /// Step was stopped by the user.
    stopped,

    pub const json_field_names = .{
        .not_started = "NOT_STARTED",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .stopped = "STOPPED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_started => "NOT_STARTED",
            .in_progress => "IN_PROGRESS",
            .completed => "COMPLETED",
            .failed => "FAILED",
            .stopped => "STOPPED",
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
