const EvaluationFormQuestionAutomationAnswerSource = @import("evaluation_form_question_automation_answer_source.zig").EvaluationFormQuestionAutomationAnswerSource;
const EvaluationFormSingleSelectQuestionAutomationOption = @import("evaluation_form_single_select_question_automation_option.zig").EvaluationFormSingleSelectQuestionAutomationOption;

/// Information about the automation configuration in single select questions.
/// Automation options are evaluated in
/// order, and the first matched option is applied. If no automation option
/// matches, and there is a default option, then
/// the default option is applied.
pub const EvaluationFormSingleSelectQuestionAutomation = struct {
    /// Automation answer source.
    answer_source: ?EvaluationFormQuestionAutomationAnswerSource,

    /// The identifier of the default answer option, when none of the automation
    /// options match the criteria.
    default_option_ref_id: ?[]const u8,

    /// The automation options of the single select question.
    options: []const EvaluationFormSingleSelectQuestionAutomationOption = &.{},

    pub const json_field_names = .{
        .answer_source = "AnswerSource",
        .default_option_ref_id = "DefaultOptionRefId",
        .options = "Options",
    };
};
