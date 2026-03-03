const std = @import("std");

/// The current status of the bulk deployment.
pub const BulkDeploymentStatus = enum {
    initializing,
    running,
    completed,
    stopping,
    stopped,
    failed,

    pub const json_field_names = .{
        .initializing = "Initializing",
        .running = "Running",
        .completed = "Completed",
        .stopping = "Stopping",
        .stopped = "Stopped",
        .failed = "Failed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initializing => "Initializing",
            .running => "Running",
            .completed => "Completed",
            .stopping => "Stopping",
            .stopped => "Stopped",
            .failed => "Failed",
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
