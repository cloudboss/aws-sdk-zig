/// Information about scores of a contact evaluation item (section or question).
pub const EvaluationScore = struct {
    /// Weight applied to this evaluation score.
    applied_weight: ?f64,

    /// The flag that marks the item as automatic fail. If the item or a child item
    /// gets an automatic fail answer, this
    /// flag will be true.
    automatic_fail: bool = false,

    /// The flag to mark the item as not applicable for scoring.
    not_applicable: bool = false,

    /// The score percentage for an item in a contact evaluation.
    percentage: f64 = 0,

    pub const json_field_names = .{
        .applied_weight = "AppliedWeight",
        .automatic_fail = "AutomaticFail",
        .not_applicable = "NotApplicable",
        .percentage = "Percentage",
    };
};
