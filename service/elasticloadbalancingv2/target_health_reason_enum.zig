const std = @import("std");

pub const TargetHealthReasonEnum = enum {
    registration_in_progress,
    initial_health_checking,
    response_code_mismatch,
    timeout,
    failed_health_checks,
    not_registered,
    not_in_use,
    deregistration_in_progress,
    invalid_state,
    ip_unusable,
    health_check_disabled,
    internal_error,

    pub const json_field_names = .{
        .registration_in_progress = "Elb.RegistrationInProgress",
        .initial_health_checking = "Elb.InitialHealthChecking",
        .response_code_mismatch = "Target.ResponseCodeMismatch",
        .timeout = "Target.Timeout",
        .failed_health_checks = "Target.FailedHealthChecks",
        .not_registered = "Target.NotRegistered",
        .not_in_use = "Target.NotInUse",
        .deregistration_in_progress = "Target.DeregistrationInProgress",
        .invalid_state = "Target.InvalidState",
        .ip_unusable = "Target.IpUnusable",
        .health_check_disabled = "Target.HealthCheckDisabled",
        .internal_error = "Elb.InternalError",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .registration_in_progress => "Elb.RegistrationInProgress",
            .initial_health_checking => "Elb.InitialHealthChecking",
            .response_code_mismatch => "Target.ResponseCodeMismatch",
            .timeout => "Target.Timeout",
            .failed_health_checks => "Target.FailedHealthChecks",
            .not_registered => "Target.NotRegistered",
            .not_in_use => "Target.NotInUse",
            .deregistration_in_progress => "Target.DeregistrationInProgress",
            .invalid_state => "Target.InvalidState",
            .ip_unusable => "Target.IpUnusable",
            .health_check_disabled => "Target.HealthCheckDisabled",
            .internal_error => "Elb.InternalError",
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
