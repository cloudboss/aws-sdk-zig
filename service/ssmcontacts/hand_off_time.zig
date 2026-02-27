/// Details about when an on-call rotation shift begins or ends.
pub const HandOffTime = struct {
    /// The hour when an on-call rotation shift begins or ends.
    hour_of_day: i32 = 0,

    /// The minute when an on-call rotation shift begins or ends.
    minute_of_hour: i32 = 0,

    pub const json_field_names = .{
        .hour_of_day = "HourOfDay",
        .minute_of_hour = "MinuteOfHour",
    };
};
