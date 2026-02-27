const Comparison = @import("comparison.zig").Comparison;

/// Contains information about the threshold for service level metrics.
pub const Threshold = struct {
    /// The type of comparison. Only "less than" (LT) comparisons are supported.
    comparison: ?Comparison,

    /// The threshold value to compare.
    threshold_value: ?f64,

    pub const json_field_names = .{
        .comparison = "Comparison",
        .threshold_value = "ThresholdValue",
    };
};
