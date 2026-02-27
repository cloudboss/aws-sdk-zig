/// Describes the percentile and percentile value.
pub const PercentPair = struct {
    /// The percentile.
    percent: f64 = 0,

    /// The value of the percentile.
    value: f64 = 0,

    pub const json_field_names = .{
        .percent = "percent",
        .value = "value",
    };
};
