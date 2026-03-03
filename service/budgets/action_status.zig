const std = @import("std");

pub const ActionStatus = enum {
    standby,
    pending,
    execution_in_progress,
    execution_success,
    execution_failure,
    reverse_in_progress,
    reverse_success,
    reverse_failure,
    reset_in_progress,
    reset_failure,

    pub const json_field_names = .{
        .standby = "STANDBY",
        .pending = "PENDING",
        .execution_in_progress = "EXECUTION_IN_PROGRESS",
        .execution_success = "EXECUTION_SUCCESS",
        .execution_failure = "EXECUTION_FAILURE",
        .reverse_in_progress = "REVERSE_IN_PROGRESS",
        .reverse_success = "REVERSE_SUCCESS",
        .reverse_failure = "REVERSE_FAILURE",
        .reset_in_progress = "RESET_IN_PROGRESS",
        .reset_failure = "RESET_FAILURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standby => "STANDBY",
            .pending => "PENDING",
            .execution_in_progress => "EXECUTION_IN_PROGRESS",
            .execution_success => "EXECUTION_SUCCESS",
            .execution_failure => "EXECUTION_FAILURE",
            .reverse_in_progress => "REVERSE_IN_PROGRESS",
            .reverse_success => "REVERSE_SUCCESS",
            .reverse_failure => "REVERSE_FAILURE",
            .reset_in_progress => "RESET_IN_PROGRESS",
            .reset_failure => "RESET_FAILURE",
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
