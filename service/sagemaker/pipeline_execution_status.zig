const std = @import("std");

pub const PipelineExecutionStatus = enum {
    executing,
    stopping,
    stopped,
    failed,
    succeeded,
    /// The pipeline completed all reachable work after one or more steps failed.
    /// Every failed step was handled by a scheduled downstream step whose trigger
    /// is `Failed` or `Any`.
    completed_with_failures,

    pub const json_field_names = .{
        .executing = "Executing",
        .stopping = "Stopping",
        .stopped = "Stopped",
        .failed = "Failed",
        .succeeded = "Succeeded",
        .completed_with_failures = "CompletedWithFailures",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .executing => "Executing",
            .stopping => "Stopping",
            .stopped => "Stopped",
            .failed => "Failed",
            .succeeded => "Succeeded",
            .completed_with_failures => "CompletedWithFailures",
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
