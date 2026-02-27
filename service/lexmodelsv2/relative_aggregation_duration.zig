const TimeDimension = @import("time_dimension.zig").TimeDimension;

/// Specifies the time window that utterance statistics are returned
/// for. The time window is always relative to the last time that the that
/// utterances were aggregated. For example, if the
/// `ListAggregatedUtterances` operation is called at 1600,
/// the time window is set to 1 hour, and the last refresh time was 1530,
/// only utterances made between 1430 and 1530 are returned.
///
/// You can choose the time window that statistics should be returned
/// for.
///
/// * **Hours** - You can request
/// utterance statistics for 1, 3, 6, 12, or 24 hour time windows.
/// Statistics are refreshed every half hour for 1 hour time windows,
/// and hourly for the other time windows.
///
/// * **Days** - You can request
/// utterance statistics for 3 days. Statistics are refreshed every 6
/// hours.
///
/// * **Weeks** - You can see
/// statistics for one or two weeks. Statistics are refreshed every
/// 12 hours for one week time windows, and once per day for two week
/// time windows.
pub const RelativeAggregationDuration = struct {
    /// The type of time period that the `timeValue` field
    /// represents.
    time_dimension: TimeDimension,

    /// The period of the time window to gather statistics for. The valid
    /// value depends on the setting of the `timeDimension`
    /// field.
    ///
    /// * `Hours` - 1/3/6/12/24
    ///
    /// * `Days` - 3
    ///
    /// * `Weeks` - 1/2
    time_value: i32,

    pub const json_field_names = .{
        .time_dimension = "timeDimension",
        .time_value = "timeValue",
    };
};
