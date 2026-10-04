const std = @import("std");

pub const MaintenanceWindowExecutionStatus = enum {
    pending,
    in_progress,
    success,
    failed,
    timed_out,
    cancelling,
    cancelled,
    skipped_overlapping,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .success = "SUCCESS",
        .failed = "FAILED",
        .timed_out = "TIMED_OUT",
        .cancelling = "CANCELLING",
        .cancelled = "CANCELLED",
        .skipped_overlapping = "SKIPPED_OVERLAPPING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .in_progress => "IN_PROGRESS",
            .success => "SUCCESS",
            .failed => "FAILED",
            .timed_out => "TIMED_OUT",
            .cancelling => "CANCELLING",
            .cancelled => "CANCELLED",
            .skipped_overlapping => "SKIPPED_OVERLAPPING",
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
