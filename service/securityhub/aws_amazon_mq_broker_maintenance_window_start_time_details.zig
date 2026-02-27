/// The scheduled time period (UTC) during which Amazon MQ begins to apply
/// pending updates or patches to the broker.
pub const AwsAmazonMqBrokerMaintenanceWindowStartTimeDetails = struct {
    /// The day of the week on which the maintenance window falls.
    day_of_week: ?[]const u8,

    /// The time, in 24-hour format, on which the maintenance window falls.
    time_of_day: ?[]const u8,

    /// The time zone in either the Country/City format or the UTC offset format.
    /// UTC is the default format.
    time_zone: ?[]const u8,

    pub const json_field_names = .{
        .day_of_week = "DayOfWeek",
        .time_of_day = "TimeOfDay",
        .time_zone = "TimeZone",
    };
};
