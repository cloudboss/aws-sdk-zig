const EvaluationFormTextQuestionAutomation = @import("evaluation_form_text_question_automation.zig").EvaluationFormTextQuestionAutomation;

/// Information about properties for a text question in an evaluation form.
pub const EvaluationFormTextQuestionProperties = struct {
    /// The automation properties of the text question.
    automation: ?EvaluationFormTextQuestionAutomation = null,

    pub const json_field_names = .{
        .automation = "Automation",
    };
};
