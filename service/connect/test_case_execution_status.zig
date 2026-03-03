const std = @import("std");

/// The status of a test case execution.
pub const TestCaseExecutionStatus = enum {
    initiated,
    passed,
    failed,
    in_progress,
    stopped,

    pub const json_field_names = .{
        .initiated = "INITIATED",
        .passed = "PASSED",
        .failed = "FAILED",
        .in_progress = "IN_PROGRESS",
        .stopped = "STOPPED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initiated => "INITIATED",
            .passed => "PASSED",
            .failed => "FAILED",
            .in_progress => "IN_PROGRESS",
            .stopped => "STOPPED",
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
