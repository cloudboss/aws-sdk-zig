const std = @import("std");

/// The type of instance.
pub const JobFlowExecutionState = enum {
    starting,
    bootstrapping,
    running,
    waiting,
    shutting_down,
    terminated,
    completed,
    failed,

    pub const json_field_names = .{
        .starting = "STARTING",
        .bootstrapping = "BOOTSTRAPPING",
        .running = "RUNNING",
        .waiting = "WAITING",
        .shutting_down = "SHUTTING_DOWN",
        .terminated = "TERMINATED",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .starting => "STARTING",
            .bootstrapping => "BOOTSTRAPPING",
            .running => "RUNNING",
            .waiting => "WAITING",
            .shutting_down => "SHUTTING_DOWN",
            .terminated => "TERMINATED",
            .completed => "COMPLETED",
            .failed => "FAILED",
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
