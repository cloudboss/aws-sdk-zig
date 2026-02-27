/// Specifies the schedule settings for a journey.
pub const JourneySchedule = struct {
    /// The scheduled time, in ISO 8601 format, when the journey ended or will end.
    end_time: ?i64,

    /// The scheduled time, in ISO 8601 format, when the journey began or will
    /// begin.
    start_time: ?i64,

    /// The starting UTC offset for the journey schedule, if the value of the
    /// journey's LocalTime property is true. Valid values are: UTC,
    /// UTC+01, UTC+02, UTC+03, UTC+03:30, UTC+04, UTC+04:30, UTC+05, UTC+05:30,
    /// UTC+05:45, UTC+06, UTC+06:30, UTC+07, UTC+08, UTC+08:45, UTC+09, UTC+09:30,
    /// UTC+10, UTC+10:30, UTC+11, UTC+12, UTC+12:45, UTC+13, UTC+13:45, UTC-02,
    /// UTC-02:30, UTC-03, UTC-03:30, UTC-04, UTC-05, UTC-06, UTC-07, UTC-08,
    /// UTC-09,
    /// UTC-09:30, UTC-10, and UTC-11.
    timezone: ?[]const u8,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
        .timezone = "Timezone",
    };
};
