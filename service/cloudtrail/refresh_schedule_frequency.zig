const RefreshScheduleFrequencyUnit = @import("refresh_schedule_frequency_unit.zig").RefreshScheduleFrequencyUnit;

/// Specifies the frequency for a dashboard refresh schedule.
///
/// For a custom dashboard, you can schedule a refresh for every 1, 6, 12, or 24
/// hours, or every day.
pub const RefreshScheduleFrequency = struct {
    /// The unit to use for the refresh.
    ///
    /// For custom dashboards, the unit can be `HOURS` or `DAYS`.
    ///
    /// For the Highlights dashboard, the `Unit` must be `HOURS`.
    unit: ?RefreshScheduleFrequencyUnit,

    /// The value for the refresh schedule.
    ///
    /// For custom dashboards, the following values are valid when the unit is
    /// `HOURS`: `1`, `6`, `12`, `24`
    ///
    /// For custom dashboards, the only valid value when the unit is `DAYS` is `1`.
    ///
    /// For the Highlights dashboard, the `Value` must be `6`.
    value: ?i32,

    pub const json_field_names = .{
        .unit = "Unit",
        .value = "Value",
    };
};
