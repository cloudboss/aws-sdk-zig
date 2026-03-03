const RecurrenceFrequency = @import("recurrence_frequency.zig").RecurrenceFrequency;

/// Specifies the detailed pattern for event recurrence. Use this to define
/// complex scheduling rules such as "every 2nd Tuesday of the month" or "every
/// 3 months on the 15th".
pub const RecurrencePattern = struct {
    /// Specifies which month the event should occur in (1-12, where 1=January,
    /// 12=December). Used with YEARLY frequency to schedule events in specific
    /// month.
    ///
    /// Note: It does not accept multiple values in the same list
    by_month: ?[]const i32 = null,

    /// Specifies which day of the month the event should occur on (1-31). Used with
    /// MONTHLY or YEARLY frequency to schedule events on specific date within a
    /// month.
    ///
    /// Examples:
    /// [15] for events on the 15th of each month,
    /// [-1] for events on the last day of month.
    ///
    /// Note: It does not accept multiple values in the same list. If a specified
    /// day doesn't exist in a particular month (e.g., day 31 in February), the
    /// event will be skipped for that month. This field cannot be used
    /// simultaneously with ByWeekdayOccurrence as they represent different
    /// scheduling approaches (specific dates vs. relative weekday positions).
    by_month_day: ?[]const i32 = null,

    /// Specifies which occurrence of a weekday within the month the event should
    /// occur on. Must be used with MONTHLY or YEARLY frequency.
    ///
    /// Example: 2 corresponds to second occurrence of the weekday in the month. -1
    /// corresponds to last occurrence of the weekday in the month
    ///
    /// The weekday itself is specified separately in the HoursOfOperationConfig.
    /// Example: To schedule the recurring event for the 2nd Thursday of April every
    /// year, set ByWeekdayOccurrence=[2], Day=THURSDAY, ByMonth=[4], Frequency:
    /// YEARLY and INTERVAL=1.
    by_weekday_occurrence: ?[]const i32 = null,

    /// Defines how often the pattern repeats. This is the base unit for the
    /// recurrence schedule and works in conjunction with the Interval field to
    /// determine the exact repetition sequence.
    frequency: RecurrenceFrequency,

    /// Specifies the number of frequency units between each occurrence. Must be a
    /// positive integer.
    ///
    /// Examples: To repeat every week, set Interval=1 with WEEKLY frequency. To
    /// repeat every two months, set Interval=2 with MONTHLY frequency.
    interval: i32,

    pub const json_field_names = .{
        .by_month = "ByMonth",
        .by_month_day = "ByMonthDay",
        .by_weekday_occurrence = "ByWeekdayOccurrence",
        .frequency = "Frequency",
        .interval = "Interval",
    };
};
