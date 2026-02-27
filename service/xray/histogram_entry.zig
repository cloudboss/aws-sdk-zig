/// An entry in a histogram for a statistic. A histogram maps the range of
/// observed values
/// on the X axis, and the prevalence of each value on the Y axis.
pub const HistogramEntry = struct {
    /// The prevalence of the entry.
    count: i32 = 0,

    /// The value of the entry.
    value: f64 = 0,

    pub const json_field_names = .{
        .count = "Count",
        .value = "Value",
    };
};
