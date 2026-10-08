const std = @import("std");

/// The status of a test run through its lifecycle.
pub const TestRunStatus = enum {
    initializing,
    running,
    stopping,
    passed,
    failed,
    stopped,
    @"error",

    pub const json_field_names = .{
        .initializing = "INITIALIZING",
        .running = "RUNNING",
        .stopping = "STOPPING",
        .passed = "PASSED",
        .failed = "FAILED",
        .stopped = "STOPPED",
        .@"error" = "ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initializing => "INITIALIZING",
            .running => "RUNNING",
            .stopping => "STOPPING",
            .passed => "PASSED",
            .failed => "FAILED",
            .stopped => "STOPPED",
            .@"error" => "ERROR",
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
