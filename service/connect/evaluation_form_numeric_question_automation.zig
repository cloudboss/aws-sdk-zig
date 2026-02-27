const EvaluationFormQuestionAutomationAnswerSource = @import("evaluation_form_question_automation_answer_source.zig").EvaluationFormQuestionAutomationAnswerSource;
const NumericQuestionPropertyValueAutomation = @import("numeric_question_property_value_automation.zig").NumericQuestionPropertyValueAutomation;

/// Information about the automation configuration in numeric questions.
pub const EvaluationFormNumericQuestionAutomation = union(enum) {
    /// A source of automation answer for numeric question.
    answer_source: ?EvaluationFormQuestionAutomationAnswerSource,
    /// The property value of the automation.
    property_value: ?NumericQuestionPropertyValueAutomation,

    pub const json_field_names = .{
        .answer_source = "AnswerSource",
        .property_value = "PropertyValue",
    };
};
