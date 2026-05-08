const ConfidenceInterval = @import("confidence_interval.zig").ConfidenceInterval;

/// Statistical results for a treatment variant compared against the control.
pub const VariantResult = struct {
    /// The absolute change in mean score compared to the control variant.
    absolute_change: ?f64 = null,

    /// The confidence interval for the observed difference.
    confidence_interval: ?ConfidenceInterval = null,

    /// Whether the observed difference is statistically significant.
    is_significant: bool,

    /// The mean evaluation score for this variant.
    mean: f64,

    /// The percentage change in mean score compared to the control variant.
    percent_change: ?f64 = null,

    /// The p-value indicating the statistical significance of the observed
    /// difference.
    p_value: ?f64 = null,

    /// The number of sessions evaluated for this variant.
    sample_size: i32,

    /// The name of the treatment variant.
    variant_name: []const u8,

    pub const json_field_names = .{
        .absolute_change = "absoluteChange",
        .confidence_interval = "confidenceInterval",
        .is_significant = "isSignificant",
        .mean = "mean",
        .percent_change = "percentChange",
        .p_value = "pValue",
        .sample_size = "sampleSize",
        .variant_name = "variantName",
    };
};
