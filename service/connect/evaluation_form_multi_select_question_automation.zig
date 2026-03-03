const EvaluationFormQuestionAutomationAnswerSource = @import("evaluation_form_question_automation_answer_source.zig").EvaluationFormQuestionAutomationAnswerSource;
const EvaluationFormMultiSelectQuestionAutomationOption = @import("evaluation_form_multi_select_question_automation_option.zig").EvaluationFormMultiSelectQuestionAutomationOption;

/// Automation configuration for multi-select questions.
pub const EvaluationFormMultiSelectQuestionAutomation = struct {
    answer_source: ?EvaluationFormQuestionAutomationAnswerSource = null,

    /// Reference IDs of default options.
    default_option_ref_ids: ?[]const []const u8 = null,

    /// Automation options for the multi-select question.
    options: ?[]const EvaluationFormMultiSelectQuestionAutomationOption = null,

    pub const json_field_names = .{
        .answer_source = "AnswerSource",
        .default_option_ref_ids = "DefaultOptionRefIds",
        .options = "Options",
    };
};
