pub const ConflictExceptionReason = enum {
    zonal_shift_already_exists,
    zonal_shift_status_not_active,
    simultaneous_zonal_shifts_conflict,
    practice_configuration_already_exists,
    autoshift_enabled,
    practice_configuration_does_not_exist,
    zonal_autoshift_active,
    practice_outcome_alarms_red,
    practice_blocking_alarms_red,
    practice_in_blocked_dates,
    practice_in_blocked_windows,
    practice_outside_allowed_windows,

    pub const json_field_names = .{
        .zonal_shift_already_exists = "ZONAL_SHIFT_ALREADY_EXISTS",
        .zonal_shift_status_not_active = "ZONAL_SHIFT_STATUS_NOT_ACTIVE",
        .simultaneous_zonal_shifts_conflict = "SIMULTANEOUS_ZONAL_SHIFTS_CONFLICT",
        .practice_configuration_already_exists = "PRACTICE_CONFIGURATION_ALREADY_EXISTS",
        .autoshift_enabled = "AUTOSHIFT_ENABLED",
        .practice_configuration_does_not_exist = "PRACTICE_CONFIGURATION_DOES_NOT_EXIST",
        .zonal_autoshift_active = "ZONAL_AUTOSHIFT_ACTIVE",
        .practice_outcome_alarms_red = "PRACTICE_OUTCOME_ALARMS_RED",
        .practice_blocking_alarms_red = "PRACTICE_BLOCKING_ALARMS_RED",
        .practice_in_blocked_dates = "PRACTICE_IN_BLOCKED_DATES",
        .practice_in_blocked_windows = "PRACTICE_IN_BLOCKED_WINDOWS",
        .practice_outside_allowed_windows = "PRACTICE_OUTSIDE_ALLOWED_WINDOWS",
    };
};
