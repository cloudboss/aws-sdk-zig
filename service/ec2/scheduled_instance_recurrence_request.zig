/// Describes the recurring schedule for a Scheduled Instance.
pub const ScheduledInstanceRecurrenceRequest = struct {
    /// The frequency (`Daily`, `Weekly`, or `Monthly`).
    frequency: ?[]const u8,

    /// The interval quantity. The interval unit depends on the value of
    /// `Frequency`. For example, every 2
    /// weeks or every 2 months.
    interval: ?i32,

    /// The days. For a monthly schedule, this is one or more days of the month
    /// (1-31). For a weekly schedule, this is one or more days of the week (1-7,
    /// where 1 is Sunday). You can't specify this value with a daily schedule. If
    /// the occurrence is relative to the end of the month, you can specify only a
    /// single day.
    occurrence_days: ?[]const i32,

    /// Indicates whether the occurrence is relative to the end of the specified
    /// week or month. You can't specify this value with a daily schedule.
    occurrence_relative_to_end: ?bool,

    /// The unit for `OccurrenceDays` (`DayOfWeek` or `DayOfMonth`).
    /// This value is required for a monthly schedule.
    /// You can't specify `DayOfWeek` with a weekly schedule.
    /// You can't specify this value with a daily schedule.
    occurrence_unit: ?[]const u8,
};
