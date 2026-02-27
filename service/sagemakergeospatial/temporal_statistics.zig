pub const TemporalStatistics = enum {
    /// MEAN
    mean,
    /// MEDIAN
    median,
    /// STANDARD_DEVIATION
    standard_deviation,

    pub const json_field_names = .{
        .mean = "MEAN",
        .median = "MEDIAN",
        .standard_deviation = "STANDARD_DEVIATION",
    };
};
