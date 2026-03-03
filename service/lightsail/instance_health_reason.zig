const std = @import("std");

pub const InstanceHealthReason = enum {
    lb_registration_in_progress,
    lb_initial_health_checking,
    lb_internal_error,
    instance_response_code_mismatch,
    instance_timeout,
    instance_failed_health_checks,
    instance_not_registered,
    instance_not_in_use,
    instance_deregistration_in_progress,
    instance_invalid_state,
    instance_ip_unusable,

    pub const json_field_names = .{
        .lb_registration_in_progress = "Lb.RegistrationInProgress",
        .lb_initial_health_checking = "Lb.InitialHealthChecking",
        .lb_internal_error = "Lb.InternalError",
        .instance_response_code_mismatch = "Instance.ResponseCodeMismatch",
        .instance_timeout = "Instance.Timeout",
        .instance_failed_health_checks = "Instance.FailedHealthChecks",
        .instance_not_registered = "Instance.NotRegistered",
        .instance_not_in_use = "Instance.NotInUse",
        .instance_deregistration_in_progress = "Instance.DeregistrationInProgress",
        .instance_invalid_state = "Instance.InvalidState",
        .instance_ip_unusable = "Instance.IpUnusable",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .lb_registration_in_progress => "Lb.RegistrationInProgress",
            .lb_initial_health_checking => "Lb.InitialHealthChecking",
            .lb_internal_error => "Lb.InternalError",
            .instance_response_code_mismatch => "Instance.ResponseCodeMismatch",
            .instance_timeout => "Instance.Timeout",
            .instance_failed_health_checks => "Instance.FailedHealthChecks",
            .instance_not_registered => "Instance.NotRegistered",
            .instance_not_in_use => "Instance.NotInUse",
            .instance_deregistration_in_progress => "Instance.DeregistrationInProgress",
            .instance_invalid_state => "Instance.InvalidState",
            .instance_ip_unusable => "Instance.IpUnusable",
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
