/// This is your gateway's weekly maintenance start time including the day and
/// time of the week.
/// Note that values are in terms of the gateway's time zone. Can be weekly or
/// monthly.
pub const MaintenanceStartTime = struct {
    /// The day of the month component of the maintenance start time represented as
    /// an ordinal number from
    /// 1 to 28, where 1 represents the first day of the month and 28 represents the
    /// last day of the month.
    day_of_month: ?i32 = null,

    /// An ordinal number between 0 and 6 that represents the day of the week, where
    /// 0 represents Sunday
    /// and 6 represents Saturday. The day of week is in the time zone of the
    /// gateway.
    day_of_week: ?i32 = null,

    /// The hour component of the maintenance start time represented as *hh*,
    /// where *hh* is the hour (0 to 23). The hour of the day is in the time zone of
    /// the gateway.
    hour_of_day: i32,

    /// The minute component of the maintenance start time represented as *mm*,
    /// where
    /// *mm* is the minute (0 to 59). The minute of the hour is in the time zone of
    /// the gateway.
    minute_of_hour: i32,

    pub const json_field_names = .{
        .day_of_month = "DayOfMonth",
        .day_of_week = "DayOfWeek",
        .hour_of_day = "HourOfDay",
        .minute_of_hour = "MinuteOfHour",
    };
};
