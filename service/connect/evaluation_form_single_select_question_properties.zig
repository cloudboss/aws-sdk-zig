const EvaluationFormSingleSelectQuestionAutomation = @import("evaluation_form_single_select_question_automation.zig").EvaluationFormSingleSelectQuestionAutomation;
const EvaluationFormSingleSelectQuestionDisplayMode = @import("evaluation_form_single_select_question_display_mode.zig").EvaluationFormSingleSelectQuestionDisplayMode;
const EvaluationFormSingleSelectQuestionOption = @import("evaluation_form_single_select_question_option.zig").EvaluationFormSingleSelectQuestionOption;

/// Information about the options in single select questions.
pub const EvaluationFormSingleSelectQuestionProperties = struct {
    /// The display mode of the single select question.
    automation: ?EvaluationFormSingleSelectQuestionAutomation,

    /// The display mode of the single select question.
    display_as: ?EvaluationFormSingleSelectQuestionDisplayMode,

    /// The answer options of the single select question.
    options: []const EvaluationFormSingleSelectQuestionOption,

    pub const json_field_names = .{
        .automation = "Automation",
        .display_as = "DisplayAs",
        .options = "Options",
    };
};
