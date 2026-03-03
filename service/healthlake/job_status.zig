const std = @import("std");

pub const JobStatus = enum {
    submitted,
    queued,
    in_progress,
    completed_with_errors,
    completed,
    failed,
    cancel_submitted,
    cancel_in_progress,
    cancel_completed,
    cancel_failed,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .queued = "QUEUED",
        .in_progress = "IN_PROGRESS",
        .completed_with_errors = "COMPLETED_WITH_ERRORS",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .cancel_submitted = "CANCEL_SUBMITTED",
        .cancel_in_progress = "CANCEL_IN_PROGRESS",
        .cancel_completed = "CANCEL_COMPLETED",
        .cancel_failed = "CANCEL_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .submitted => "SUBMITTED",
            .queued => "QUEUED",
            .in_progress => "IN_PROGRESS",
            .completed_with_errors => "COMPLETED_WITH_ERRORS",
            .completed => "COMPLETED",
            .failed => "FAILED",
            .cancel_submitted => "CANCEL_SUBMITTED",
            .cancel_in_progress => "CANCEL_IN_PROGRESS",
            .cancel_completed => "CANCEL_COMPLETED",
            .cancel_failed => "CANCEL_FAILED",
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
