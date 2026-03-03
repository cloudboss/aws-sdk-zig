/// Describes the recurring schedule for a Scheduled Instance.
pub const ScheduledInstanceRecurrence = struct {
    /// The frequency (`Daily`, `Weekly`, or `Monthly`).
    frequency: ?[]const u8 = null,

    /// The interval quantity. The interval unit depends on the value of
    /// `frequency`. For example, every 2
    /// weeks or every 2 months.
    interval: ?i32 = null,

    /// The days. For a monthly schedule, this is one or more days of the month
    /// (1-31). For a weekly schedule, this is one or more days of the week (1-7,
    /// where 1 is Sunday).
    occurrence_day_set: ?[]const i32 = null,

    /// Indicates whether the occurrence is relative to the end of the specified
    /// week or month.
    occurrence_relative_to_end: ?bool = null,

    /// The unit for `occurrenceDaySet` (`DayOfWeek` or `DayOfMonth`).
    occurrence_unit: ?[]const u8 = null,
};
