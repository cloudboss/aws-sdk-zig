const std = @import("std");

/// The status of a step within a Recovery Plan execution.
pub const RecoveryPlanExecutionStepStatus = enum {
    not_started,
    executing,
    waiting,
    completed,
    failed,
    timed_out,
    skipped,

    pub const json_field_names = .{
        .not_started = "NOT_STARTED",
        .executing = "EXECUTING",
        .waiting = "WAITING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .timed_out = "TIMED_OUT",
        .skipped = "SKIPPED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_started => "NOT_STARTED",
            .executing => "EXECUTING",
            .waiting => "WAITING",
            .completed => "COMPLETED",
            .failed => "FAILED",
            .timed_out => "TIMED_OUT",
            .skipped => "SKIPPED",
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
