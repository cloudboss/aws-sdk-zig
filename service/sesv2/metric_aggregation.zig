/// The aggregation to apply to a metric, can be one of the following:
///
/// * `VOLUME` - The volume of events for this metric.
///
/// * `RATE` - The rate for this metric relative to the
/// `SEND` metric volume.
pub const MetricAggregation = enum {
    rate,
    volume,

    pub const json_field_names = .{
        .rate = "RATE",
        .volume = "VOLUME",
    };
};
