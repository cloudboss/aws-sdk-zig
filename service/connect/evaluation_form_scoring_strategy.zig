const EvaluationFormScoringMode = @import("evaluation_form_scoring_mode.zig").EvaluationFormScoringMode;
const EvaluationFormScoringStatus = @import("evaluation_form_scoring_status.zig").EvaluationFormScoringStatus;

/// Information about scoring strategy for an evaluation form.
pub const EvaluationFormScoringStrategy = struct {
    /// The scoring mode of the evaluation form.
    mode: EvaluationFormScoringMode,

    /// The scoring status of the evaluation form.
    status: EvaluationFormScoringStatus,

    pub const json_field_names = .{
        .mode = "Mode",
        .status = "Status",
    };
};
