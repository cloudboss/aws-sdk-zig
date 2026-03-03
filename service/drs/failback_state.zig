const std = @import("std");

pub const FailbackState = enum {
    failback_not_started,
    failback_in_progress,
    failback_ready_for_launch,
    failback_completed,
    failback_error,
    failback_not_ready_for_launch,
    failback_launch_state_not_available,

    pub const json_field_names = .{
        .failback_not_started = "FAILBACK_NOT_STARTED",
        .failback_in_progress = "FAILBACK_IN_PROGRESS",
        .failback_ready_for_launch = "FAILBACK_READY_FOR_LAUNCH",
        .failback_completed = "FAILBACK_COMPLETED",
        .failback_error = "FAILBACK_ERROR",
        .failback_not_ready_for_launch = "FAILBACK_NOT_READY_FOR_LAUNCH",
        .failback_launch_state_not_available = "FAILBACK_LAUNCH_STATE_NOT_AVAILABLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .failback_not_started => "FAILBACK_NOT_STARTED",
            .failback_in_progress => "FAILBACK_IN_PROGRESS",
            .failback_ready_for_launch => "FAILBACK_READY_FOR_LAUNCH",
            .failback_completed => "FAILBACK_COMPLETED",
            .failback_error => "FAILBACK_ERROR",
            .failback_not_ready_for_launch => "FAILBACK_NOT_READY_FOR_LAUNCH",
            .failback_launch_state_not_available => "FAILBACK_LAUNCH_STATE_NOT_AVAILABLE",
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
