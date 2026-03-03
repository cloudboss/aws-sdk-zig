const InclusionAnnotationValue = @import("inclusion_annotation_value.zig").InclusionAnnotationValue;

/// The statistic model result.
pub const StatisticModelResult = struct {
    /// The actual value.
    actual_value: ?f64 = null,

    /// The date.
    date: ?i64 = null,

    /// The inclusion annotation.
    inclusion_annotation: ?InclusionAnnotationValue = null,

    /// The lower bound.
    lower_bound: ?f64 = null,

    /// The predicted value.
    predicted_value: ?f64 = null,

    /// The upper bound.
    upper_bound: ?f64 = null,

    pub const json_field_names = .{
        .actual_value = "ActualValue",
        .date = "Date",
        .inclusion_annotation = "InclusionAnnotation",
        .lower_bound = "LowerBound",
        .predicted_value = "PredictedValue",
        .upper_bound = "UpperBound",
    };
};
