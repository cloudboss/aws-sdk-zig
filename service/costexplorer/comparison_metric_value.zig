/// Contains cost or usage metric values for comparing two time periods. Each
/// value
/// includes amounts for the baseline and comparison time periods, their
/// difference, and the
/// unit of measurement.
pub const ComparisonMetricValue = struct {
    /// The numeric value for the baseline time period measurement.
    baseline_time_period_amount: ?[]const u8,

    /// The numeric value for the comparison time period measurement.
    comparison_time_period_amount: ?[]const u8,

    /// The calculated difference between `ComparisonTimePeriodAmount` and
    /// `BaselineTimePeriodAmount`.
    difference: ?[]const u8,

    /// The unit of measurement applicable to all numeric values in this comparison.
    unit: ?[]const u8,

    pub const json_field_names = .{
        .baseline_time_period_amount = "BaselineTimePeriodAmount",
        .comparison_time_period_amount = "ComparisonTimePeriodAmount",
        .difference = "Difference",
        .unit = "Unit",
    };
};
