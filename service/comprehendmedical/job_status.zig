const std = @import("std");

pub const JobStatus = enum {
    submitted,
    in_progress,
    completed,
    partial_success,
    failed,
    stop_requested,
    stopped,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .in_progress = "IN_PROGRESS",
        .completed = "COMPLETED",
        .partial_success = "PARTIAL_SUCCESS",
        .failed = "FAILED",
        .stop_requested = "STOP_REQUESTED",
        .stopped = "STOPPED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .submitted => "SUBMITTED",
            .in_progress => "IN_PROGRESS",
            .completed => "COMPLETED",
            .partial_success => "PARTIAL_SUCCESS",
            .failed => "FAILED",
            .stop_requested => "STOP_REQUESTED",
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
