const std = @import("std");

/// The state of a pipeline execution.
pub const PipelineExecutionState = enum {
    not_started,
    running,
    succeeded,
    failed,
    cancelling,
    cancelled,

    pub const json_field_names = .{
        .not_started = "NOT_STARTED",
        .running = "RUNNING",
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .cancelling = "CANCELLING",
        .cancelled = "CANCELLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_started => "NOT_STARTED",
            .running => "RUNNING",
            .succeeded => "SUCCEEDED",
            .failed => "FAILED",
            .cancelling => "CANCELLING",
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
