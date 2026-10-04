const PerformanceCategoryName = @import("performance_category_name.zig").PerformanceCategoryName;

/// Information about a score threshold for a performance category.
pub const EvaluationFormScoreThreshold = struct {
    /// The maximum score percentage for the performance category.
    max_score_percentage: f64 = 0,

    /// The minimum score percentage for the performance category.
    min_score_percentage: f64 = 0,

    /// The performance category name.
    performance_category: PerformanceCategoryName,

    pub const json_field_names = .{
        .max_score_percentage = "MaxScorePercentage",
        .min_score_percentage = "MinScorePercentage",
        .performance_category = "PerformanceCategory",
    };
};
