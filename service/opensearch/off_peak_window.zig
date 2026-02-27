const WindowStartTime = @import("window_start_time.zig").WindowStartTime;

/// A custom 10-hour, low-traffic window during which OpenSearch Service can
/// perform
/// mandatory configuration changes on the domain. These actions can include
/// scheduled
/// service software updates and blue/green Auto-Tune enhancements. OpenSearch
/// Service will
/// schedule these actions during the window that you specify.
///
/// If you don't specify a window start time, it defaults to 10:00 P.M. local
/// time.
///
/// For more information, see [Defining off-peak
/// maintenance windows for Amazon OpenSearch
/// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/off-peak.html).
pub const OffPeakWindow = struct {
    /// A custom start time for the off-peak window, in Coordinated Universal Time
    /// (UTC). The
    /// window length will always be 10 hours, so you can't specify an end time. For
    /// example, if
    /// you specify 11:00 P.M. UTC as a start time, the end time will automatically
    /// be set to
    /// 9:00 A.M.
    window_start_time: ?WindowStartTime,

    pub const json_field_names = .{
        .window_start_time = "WindowStartTime",
    };
};
