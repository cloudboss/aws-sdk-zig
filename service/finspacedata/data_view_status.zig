const std = @import("std");

/// Status of a DataView
pub const DataViewStatus = enum {
    running,
    starting,
    failed,
    cancelled,
    timeout,
    success,
    pending,
    failed_cleanup_failed,

    pub const json_field_names = .{
        .running = "RUNNING",
        .starting = "STARTING",
        .failed = "FAILED",
        .cancelled = "CANCELLED",
        .timeout = "TIMEOUT",
        .success = "SUCCESS",
        .pending = "PENDING",
        .failed_cleanup_failed = "FAILED_CLEANUP_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .running => "RUNNING",
            .starting => "STARTING",
            .failed => "FAILED",
            .cancelled => "CANCELLED",
            .timeout => "TIMEOUT",
            .success => "SUCCESS",
            .pending => "PENDING",
            .failed_cleanup_failed => "FAILED_CLEANUP_FAILED",
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
