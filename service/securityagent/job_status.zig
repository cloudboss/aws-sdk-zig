const std = @import("std");

/// Status of a pentest job.
pub const JobStatus = enum {
    /// Pentest job is currently running.
    in_progress,
    /// Pentest job is being stopped.
    stopping,
    /// Pentest job was stopped by the user.
    stopped,
    /// Pentest job failed during execution.
    failed,
    /// Pentest job completed successfully.
    completed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .stopping = "STOPPING",
        .stopped = "STOPPED",
        .failed = "FAILED",
        .completed = "COMPLETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "IN_PROGRESS",
            .stopping => "STOPPING",
            .stopped => "STOPPED",
            .failed => "FAILED",
            .completed => "COMPLETED",
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
