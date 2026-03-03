const std = @import("std");

pub const JobStatus = enum {
    pending,
    cancelled,
    running,
    completed,
    failed,
    completed_with_failures,

    pub const json_field_names = .{
        .pending = "PENDING",
        .cancelled = "CANCELLED",
        .running = "RUNNING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .completed_with_failures = "COMPLETED_WITH_FAILURES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .cancelled => "CANCELLED",
            .running => "RUNNING",
            .completed => "COMPLETED",
            .failed => "FAILED",
            .completed_with_failures => "COMPLETED_WITH_FAILURES",
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
