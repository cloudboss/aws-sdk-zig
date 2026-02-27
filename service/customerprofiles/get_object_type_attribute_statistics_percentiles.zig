/// Contains percentile statistics for object type attributes.
pub const GetObjectTypeAttributeStatisticsPercentiles = struct {
    /// The 25th percentile value of the attribute.
    p25: f64,

    /// The 5th percentile value of the attribute.
    p5: f64,

    /// The 50th percentile (median) value of the attribute.
    p50: f64,

    /// The 75th percentile value of the attribute.
    p75: f64,

    /// The 95th percentile value of the attribute.
    p95: f64,

    pub const json_field_names = .{
        .p25 = "P25",
        .p5 = "P5",
        .p50 = "P50",
        .p75 = "P75",
        .p95 = "P95",
    };
};
