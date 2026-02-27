const PerformanceInsightsReferenceComparisonValues = @import("performance_insights_reference_comparison_values.zig").PerformanceInsightsReferenceComparisonValues;

/// Reference data used to evaluate Performance Insights to determine if its
/// performance is anomalous or
/// not.
pub const PerformanceInsightsReferenceData = struct {
    /// The specific reference values used to evaluate the Performance Insights. For
    /// more information, see
    /// `
    /// [PerformanceInsightsReferenceComparisonValues](https://docs.aws.amazon.com/devops-guru/latest/APIReference/API_PerformanceInsightsReferenceComparisonValues.html)
    /// `.
    comparison_values: ?PerformanceInsightsReferenceComparisonValues,

    /// The name of the reference data.
    name: ?[]const u8,

    pub const json_field_names = .{
        .comparison_values = "ComparisonValues",
        .name = "Name",
    };
};
