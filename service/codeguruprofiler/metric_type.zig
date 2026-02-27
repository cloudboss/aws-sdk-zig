pub const MetricType = enum {
    /// Metric value aggregated for all instances of a frame name in a profile
    /// relative to the root frame.
    aggregated_relative_total_time,

    pub const json_field_names = .{
        .aggregated_relative_total_time = "AggregatedRelativeTotalTime",
    };
};
