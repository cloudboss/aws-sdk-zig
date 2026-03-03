const std = @import("std");

pub const JobStatus = enum {
    /// The Job has been submitted to run
    submitted,
    /// The Job is executing
    in_progress,
    /// The Job was cancelled
    cancelled,
    /// The Job has completed
    completed,
    /// The Job failed
    failed,
    /// The Job completed with failed runs
    completed_with_failures,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .in_progress = "IN_PROGRESS",
        .cancelled = "CANCELLED",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .completed_with_failures = "COMPLETED_WITH_FAILURES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .submitted => "SUBMITTED",
            .in_progress => "IN_PROGRESS",
            .cancelled => "CANCELLED",
            .completed => "COMPLETED",
            .failed => "FAILED",
            .completed_with_failures => "COMPLETED_WITH_FAILURES",
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
