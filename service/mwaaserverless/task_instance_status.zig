const std = @import("std");

pub const TaskInstanceStatus = enum {
    queued,
    failed,
    scheduled,
    running,
    success,
    up_for_reschedule,
    up_for_retry,
    upstream_failed,
    removed,
    restarting,
    deferred,
    none,
    cancelled,
    timeout,

    pub const json_field_names = .{
        .queued = "QUEUED",
        .failed = "FAILED",
        .scheduled = "SCHEDULED",
        .running = "RUNNING",
        .success = "SUCCESS",
        .up_for_reschedule = "UP_FOR_RESCHEDULE",
        .up_for_retry = "UP_FOR_RETRY",
        .upstream_failed = "UPSTREAM_FAILED",
        .removed = "REMOVED",
        .restarting = "RESTARTING",
        .deferred = "DEFERRED",
        .none = "NONE",
        .cancelled = "CANCELLED",
        .timeout = "TIMEOUT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .queued => "QUEUED",
            .failed => "FAILED",
            .scheduled => "SCHEDULED",
            .running => "RUNNING",
            .success => "SUCCESS",
            .up_for_reschedule => "UP_FOR_RESCHEDULE",
            .up_for_retry => "UP_FOR_RETRY",
            .upstream_failed => "UPSTREAM_FAILED",
            .removed => "REMOVED",
            .restarting => "RESTARTING",
            .deferred => "DEFERRED",
            .none => "NONE",
            .cancelled => "CANCELLED",
            .timeout => "TIMEOUT",
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
