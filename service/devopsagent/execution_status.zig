const std = @import("std");

/// Possible states of an execution
pub const ExecutionStatus = enum {
    /// Execution has failed
    failed,
    /// Execution is currently running
    running,
    /// Execution has been stopped
    stopped,
    /// Execution has been canceled
    canceled,
    /// Unlike in the case of user-initiated Cancelation, a customer won't be billed
    timed_out,
    waiting,

    pub const json_field_names = .{
        .failed = "FAILED",
        .running = "RUNNING",
        .stopped = "STOPPED",
        .canceled = "CANCELED",
        .timed_out = "TIMED_OUT",
        .waiting = "WAITING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .failed => "FAILED",
            .running => "RUNNING",
            .stopped => "STOPPED",
            .canceled => "CANCELED",
            .timed_out => "TIMED_OUT",
            .waiting => "WAITING",
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
