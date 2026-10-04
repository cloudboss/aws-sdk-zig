const PerformanceCategoryName = @import("performance_category_name.zig").PerformanceCategoryName;

/// Information about scores of a contact evaluation item (section or question).
pub const EvaluationScore = struct {
    /// Weight applied to this evaluation score.
    applied_weight: ?f64 = null,

    /// The flag that marks the item as automatic fail. If the item or a child item
    /// gets an automatic fail answer, this
    /// flag will be true.
    automatic_fail: bool = false,

    /// The points earned for the item.
    earned_points: i32 = 0,

    /// The maximum base points possible for the item.
    max_base_point: i32 = 0,

    /// The flag to mark the item as not applicable for scoring.
    not_applicable: bool = false,

    /// The score percentage for an item in a contact evaluation.
    percentage: f64 = 0,

    /// The performance category for the score.
    performance_category: ?PerformanceCategoryName = null,

    pub const json_field_names = .{
        .applied_weight = "AppliedWeight",
        .automatic_fail = "AutomaticFail",
        .earned_points = "EarnedPoints",
        .max_base_point = "MaxBasePoint",
        .not_applicable = "NotApplicable",
        .percentage = "Percentage",
        .performance_category = "PerformanceCategory",
    };
};
