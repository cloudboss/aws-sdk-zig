const std = @import("std");

pub const ClusterStateChangeReasonCode = enum {
    internal_error,
    validation_error,
    instance_failure,
    instance_fleet_timeout,
    bootstrap_failure,
    user_request,
    step_failure,
    all_steps_completed,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .validation_error = "VALIDATION_ERROR",
        .instance_failure = "INSTANCE_FAILURE",
        .instance_fleet_timeout = "INSTANCE_FLEET_TIMEOUT",
        .bootstrap_failure = "BOOTSTRAP_FAILURE",
        .user_request = "USER_REQUEST",
        .step_failure = "STEP_FAILURE",
        .all_steps_completed = "ALL_STEPS_COMPLETED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .internal_error => "INTERNAL_ERROR",
            .validation_error => "VALIDATION_ERROR",
            .instance_failure => "INSTANCE_FAILURE",
            .instance_fleet_timeout => "INSTANCE_FLEET_TIMEOUT",
            .bootstrap_failure => "BOOTSTRAP_FAILURE",
            .user_request => "USER_REQUEST",
            .step_failure => "STEP_FAILURE",
            .all_steps_completed => "ALL_STEPS_COMPLETED",
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
