const EvaluationFormQuestionAutomationAnswerSource = @import("evaluation_form_question_automation_answer_source.zig").EvaluationFormQuestionAutomationAnswerSource;

/// Information about the automation configuration in text questions.
pub const EvaluationFormTextQuestionAutomation = struct {
    /// Automation answer source.
    answer_source: ?EvaluationFormQuestionAutomationAnswerSource,

    pub const json_field_names = .{
        .answer_source = "AnswerSource",
    };
};
