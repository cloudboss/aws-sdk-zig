const EvaluationFormQuestionAutomationAnswerSourceType = @import("evaluation_form_question_automation_answer_source_type.zig").EvaluationFormQuestionAutomationAnswerSourceType;

/// A question automation answer.
pub const EvaluationFormQuestionAutomationAnswerSource = struct {
    /// The automation answer source type.
    source_type: EvaluationFormQuestionAutomationAnswerSourceType,

    pub const json_field_names = .{
        .source_type = "SourceType",
    };
};
