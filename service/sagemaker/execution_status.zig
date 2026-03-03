const std = @import("std");

pub const ExecutionStatus = enum {
    pending,
    completed,
    completed_with_violations,
    in_progress,
    failed,
    stopping,
    stopped,

    pub const json_field_names = .{
        .pending = "Pending",
        .completed = "Completed",
        .completed_with_violations = "CompletedWithViolations",
        .in_progress = "InProgress",
        .failed = "Failed",
        .stopping = "Stopping",
        .stopped = "Stopped",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "Pending",
            .completed => "Completed",
            .completed_with_violations => "CompletedWithViolations",
            .in_progress => "InProgress",
            .failed => "Failed",
            .stopping => "Stopping",
            .stopped => "Stopped",
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
