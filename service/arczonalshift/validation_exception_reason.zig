const std = @import("std");

pub const ValidationExceptionReason = enum {
    invalid_expires_in,
    invalid_status,
    missing_value,
    invalid_token,
    invalid_resource_identifier,
    invalid_az,
    unsupported_az,
    invalid_alarm_condition,
    invalid_condition_type,
    invalid_practice_blocker,
    fis_experiment_update_not_allowed,
    autoshift_update_not_allowed,
    unsupported_practice_cancel_shift_type,
    invalid_practice_allowed_window,
    conflicting_practice_windows,

    pub const json_field_names = .{
        .invalid_expires_in = "InvalidExpiresIn",
        .invalid_status = "InvalidStatus",
        .missing_value = "MissingValue",
        .invalid_token = "InvalidToken",
        .invalid_resource_identifier = "InvalidResourceIdentifier",
        .invalid_az = "InvalidAz",
        .unsupported_az = "UnsupportedAz",
        .invalid_alarm_condition = "InvalidAlarmCondition",
        .invalid_condition_type = "InvalidConditionType",
        .invalid_practice_blocker = "InvalidPracticeBlocker",
        .fis_experiment_update_not_allowed = "FISExperimentUpdateNotAllowed",
        .autoshift_update_not_allowed = "AutoshiftUpdateNotAllowed",
        .unsupported_practice_cancel_shift_type = "UnsupportedPracticeCancelShiftType",
        .invalid_practice_allowed_window = "InvalidPracticeAllowedWindow",
        .conflicting_practice_windows = "InvalidPracticeWindows",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_expires_in => "InvalidExpiresIn",
            .invalid_status => "InvalidStatus",
            .missing_value => "MissingValue",
            .invalid_token => "InvalidToken",
            .invalid_resource_identifier => "InvalidResourceIdentifier",
            .invalid_az => "InvalidAz",
            .unsupported_az => "UnsupportedAz",
            .invalid_alarm_condition => "InvalidAlarmCondition",
            .invalid_condition_type => "InvalidConditionType",
            .invalid_practice_blocker => "InvalidPracticeBlocker",
            .fis_experiment_update_not_allowed => "FISExperimentUpdateNotAllowed",
            .autoshift_update_not_allowed => "AutoshiftUpdateNotAllowed",
            .unsupported_practice_cancel_shift_type => "UnsupportedPracticeCancelShiftType",
            .invalid_practice_allowed_window => "InvalidPracticeAllowedWindow",
            .conflicting_practice_windows => "InvalidPracticeWindows",
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
