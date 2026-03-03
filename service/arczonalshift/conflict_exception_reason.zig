const std = @import("std");

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
        .zonal_shift_already_exists = "ZonalShiftAlreadyExists",
        .zonal_shift_status_not_active = "ZonalShiftStatusNotActive",
        .simultaneous_zonal_shifts_conflict = "SimultaneousZonalShiftsConflict",
        .practice_configuration_already_exists = "PracticeConfigurationAlreadyExists",
        .autoshift_enabled = "AutoShiftEnabled",
        .practice_configuration_does_not_exist = "PracticeConfigurationDoesNotExist",
        .zonal_autoshift_active = "ZonalAutoshiftActive",
        .practice_outcome_alarms_red = "PracticeOutcomeAlarmsRed",
        .practice_blocking_alarms_red = "PracticeBlockingAlarmsRed",
        .practice_in_blocked_dates = "PracticeInBlockedDates",
        .practice_in_blocked_windows = "PracticeInBlockedWindows",
        .practice_outside_allowed_windows = "PracticeOutsideAllowedWindows",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .zonal_shift_already_exists => "ZonalShiftAlreadyExists",
            .zonal_shift_status_not_active => "ZonalShiftStatusNotActive",
            .simultaneous_zonal_shifts_conflict => "SimultaneousZonalShiftsConflict",
            .practice_configuration_already_exists => "PracticeConfigurationAlreadyExists",
            .autoshift_enabled => "AutoShiftEnabled",
            .practice_configuration_does_not_exist => "PracticeConfigurationDoesNotExist",
            .zonal_autoshift_active => "ZonalAutoshiftActive",
            .practice_outcome_alarms_red => "PracticeOutcomeAlarmsRed",
            .practice_blocking_alarms_red => "PracticeBlockingAlarmsRed",
            .practice_in_blocked_dates => "PracticeInBlockedDates",
            .practice_in_blocked_windows => "PracticeInBlockedWindows",
            .practice_outside_allowed_windows => "PracticeOutsideAllowedWindows",
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
