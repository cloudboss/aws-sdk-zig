const EvaluationFormMultiSelectQuestionAutomation = @import("evaluation_form_multi_select_question_automation.zig").EvaluationFormMultiSelectQuestionAutomation;
const EvaluationFormMultiSelectQuestionDisplayMode = @import("evaluation_form_multi_select_question_display_mode.zig").EvaluationFormMultiSelectQuestionDisplayMode;
const EvaluationFormMultiSelectQuestionOption = @import("evaluation_form_multi_select_question_option.zig").EvaluationFormMultiSelectQuestionOption;

/// Properties for a multi-select question in an evaluation form.
pub const EvaluationFormMultiSelectQuestionProperties = struct {
    /// Automation configuration for this multi-select question.
    automation: ?EvaluationFormMultiSelectQuestionAutomation,

    /// Display format for the multi-select question.
    display_as: ?EvaluationFormMultiSelectQuestionDisplayMode,

    /// Options available for this multi-select question.
    options: []const EvaluationFormMultiSelectQuestionOption,

    pub const json_field_names = .{
        .automation = "Automation",
        .display_as = "DisplayAs",
        .options = "Options",
    };
};
