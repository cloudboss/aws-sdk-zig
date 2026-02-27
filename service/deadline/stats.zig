/// The minimum, maximum, average, and sum.
pub const Stats = struct {
    /// The average of the usage statistics.
    avg: ?f64,

    /// The maximum among the usage statistics.
    max: ?f64,

    /// The minimum of the usage statistics.
    min: ?f64,

    /// The sum of the usage statistics.
    sum: ?f64,

    pub const json_field_names = .{
        .avg = "avg",
        .max = "max",
        .min = "min",
        .sum = "sum",
    };
};
