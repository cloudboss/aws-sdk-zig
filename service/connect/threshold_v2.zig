/// Contains information about the threshold for service level metrics.
pub const ThresholdV2 = struct {
    /// The type of comparison. Currently, "less than" (LT), "less than equal"
    /// (LTE), and "greater than" (GT)
    /// comparisons are supported.
    comparison: ?[]const u8 = null,

    /// The threshold value to compare.
    threshold_value: ?f64 = null,

    pub const json_field_names = .{
        .comparison = "Comparison",
        .threshold_value = "ThresholdValue",
    };
};
