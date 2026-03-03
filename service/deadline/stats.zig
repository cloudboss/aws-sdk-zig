/// The minimum, maximum, average, and sum.
pub const Stats = struct {
    /// The average of the usage statistics.
    avg: ?f64 = null,

    /// The maximum among the usage statistics.
    max: ?f64 = null,

    /// The minimum of the usage statistics.
    min: ?f64 = null,

    /// The sum of the usage statistics.
    sum: ?f64 = null,

    pub const json_field_names = .{
        .avg = "avg",
        .max = "max",
        .min = "min",
        .sum = "sum",
    };
};
