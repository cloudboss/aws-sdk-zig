/// Indicates whether the network was healthy or degraded at a particular point.
/// The value is aggregated from the `startDate` to the `endDate`. Currently
/// only `five_minutes` is supported.
pub const MetricPoint = struct {
    /// The end date for the metric point. The ending time must be formatted as
    /// `yyyy-mm-ddThh:mm:ss`. For example, `2022-06-12T12:00:00.000Z`.
    end_date: ?i64,

    /// The start date for the metric point. The starting date for the metric point.
    /// The starting time must be formatted
    /// as `yyyy-mm-ddThh:mm:ss`. For example, `2022-06-10T12:00:00.000Z`.
    start_date: ?i64,

    /// The status of the metric point.
    status: ?[]const u8,

    value: ?f32,
};
