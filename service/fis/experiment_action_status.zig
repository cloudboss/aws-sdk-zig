const std = @import("std");

pub const ExperimentActionStatus = enum {
    pending,
    initiating,
    running,
    completed,
    cancelled,
    stopping,
    stopped,
    failed,
    skipped,

    pub const json_field_names = .{
        .pending = "pending",
        .initiating = "initiating",
        .running = "running",
        .completed = "completed",
        .cancelled = "cancelled",
        .stopping = "stopping",
        .stopped = "stopped",
        .failed = "failed",
        .skipped = "skipped",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "pending",
            .initiating => "initiating",
            .running => "running",
            .completed => "completed",
            .cancelled => "cancelled",
            .stopping => "stopping",
            .stopped => "stopped",
            .failed => "failed",
            .skipped => "skipped",
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
