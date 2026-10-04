const std = @import("std");

pub const ExperimentStatus = enum {
    pending,
    initiating,
    running,
    completed,
    stopping,
    stopped,
    failed,
    cancelled,

    pub const json_field_names = .{
        .pending = "pending",
        .initiating = "initiating",
        .running = "running",
        .completed = "completed",
        .stopping = "stopping",
        .stopped = "stopped",
        .failed = "failed",
        .cancelled = "cancelled",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "pending",
            .initiating => "initiating",
            .running => "running",
            .completed => "completed",
            .stopping => "stopping",
            .stopped => "stopped",
            .failed => "failed",
            .cancelled => "cancelled",
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
