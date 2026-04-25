/// Describes a bandwidth rate limit interval for a gateway. A bandwidth
/// rate limit schedule consists of one or more bandwidth rate limit intervals.
/// A bandwidth rate limit interval defines a period of time on one or more days
/// of the week, during which bandwidth rate limits are specified for uploading,
/// downloading, or both.
pub const BandwidthRateLimitInterval = struct {
    /// The average upload rate limit component of the bandwidth rate limit
    /// interval, in bits per second. This field does not appear in the response if
    /// the upload rate limit is not set.
    average_upload_rate_limit_in_bits_per_sec: ?i64 = null,

    /// The days of the week component of the bandwidth rate limit interval,
    /// represented as ordinal numbers from 0 to 6, where 0 represents Sunday and 6
    /// represents
    /// Saturday.
    days_of_week: []const i32,

    /// The hour of the day to end the bandwidth rate limit interval.
    end_hour_of_day: i32,

    /// The minute of the hour to end the bandwidth rate limit interval.
    ///
    /// The bandwidth rate limit interval ends at the end of the minute.
    /// To end an interval at the end of an hour, use the value `59`.
    end_minute_of_hour: i32,

    /// The hour of the day to start the bandwidth rate limit interval.
    start_hour_of_day: i32,

    /// The minute of the hour to start the bandwidth rate limit interval. The
    /// interval begins at the start of that minute. To begin an interval exactly at
    /// the start of the hour, use the value `0`.
    start_minute_of_hour: i32,

    pub const json_field_names = .{
        .average_upload_rate_limit_in_bits_per_sec = "AverageUploadRateLimitInBitsPerSec",
        .days_of_week = "DaysOfWeek",
        .end_hour_of_day = "EndHourOfDay",
        .end_minute_of_hour = "EndMinuteOfHour",
        .start_hour_of_day = "StartHourOfDay",
        .start_minute_of_hour = "StartMinuteOfHour",
    };
};
