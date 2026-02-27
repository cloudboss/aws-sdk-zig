/// The desired start time for an [off-peak
/// maintenance
/// window](https://docs.aws.amazon.com/opensearch-service/latest/APIReference/API_OffPeakWindow.html).
pub const WindowStartTime = struct {
    /// The start hour of the window in Coordinated Universal Time (UTC), using
    /// 24-hour time.
    /// For example, `17` refers to 5:00 P.M. UTC.
    hours: i64 = 0,

    /// The start minute of the window, in UTC.
    minutes: i64 = 0,

    pub const json_field_names = .{
        .hours = "Hours",
        .minutes = "Minutes",
    };
};
