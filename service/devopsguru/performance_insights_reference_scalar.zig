/// A reference value to compare Performance Insights metrics against to
/// determine if the metrics
/// demonstrate anomalous behavior.
pub const PerformanceInsightsReferenceScalar = struct {
    /// The reference value.
    value: ?f64 = null,

    pub const json_field_names = .{
        .value = "Value",
    };
};
