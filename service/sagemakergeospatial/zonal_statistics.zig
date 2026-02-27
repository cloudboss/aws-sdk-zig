pub const ZonalStatistics = enum {
    /// MEAN
    mean,
    /// MEDIAN
    median,
    /// STANDARD_DEVIATION
    standard_deviation,
    /// MAX
    max,
    /// MIN
    min,
    /// SUM
    sum,

    pub const json_field_names = .{
        .mean = "MEAN",
        .median = "MEDIAN",
        .standard_deviation = "STANDARD_DEVIATION",
        .max = "MAX",
        .min = "MIN",
        .sum = "SUM",
    };
};
