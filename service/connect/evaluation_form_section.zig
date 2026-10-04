const EvaluationFormItem = @import("evaluation_form_item.zig").EvaluationFormItem;
const EvaluationFormScoreThreshold = @import("evaluation_form_score_threshold.zig").EvaluationFormScoreThreshold;

/// Information about a section from an evaluation form. A section can contain
/// sections and/or questions. Evaluation
/// forms can only contain sections and subsections (two level nesting).
pub const EvaluationFormSection = struct {
    /// The instructions of the section.
    instructions: ?[]const u8 = null,

    /// The flag to exclude the section from scoring.
    is_excluded_from_scoring: bool = false,

    /// The items of the section.
    items: []const EvaluationFormItem,

    /// The identifier of the section. An identifier must be unique within the
    /// evaluation form.
    ref_id: []const u8,

    /// The score thresholds for performance categories.
    score_thresholds: ?[]const EvaluationFormScoreThreshold = null,

    /// The title of the section.
    title: []const u8,

    /// The scoring weight of the section.
    weight: f64 = 0,

    pub const json_field_names = .{
        .instructions = "Instructions",
        .is_excluded_from_scoring = "IsExcludedFromScoring",
        .items = "Items",
        .ref_id = "RefId",
        .score_thresholds = "ScoreThresholds",
        .title = "Title",
        .weight = "Weight",
    };
};
