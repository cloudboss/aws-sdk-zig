const EvaluationFormNumericQuestionAutomation = @import("evaluation_form_numeric_question_automation.zig").EvaluationFormNumericQuestionAutomation;
const EvaluationFormNumericQuestionOption = @import("evaluation_form_numeric_question_option.zig").EvaluationFormNumericQuestionOption;

/// Information about properties for a numeric question in an evaluation form.
pub const EvaluationFormNumericQuestionProperties = struct {
    /// The automation properties of the numeric question.
    automation: ?EvaluationFormNumericQuestionAutomation,

    /// The maximum answer value.
    max_value: i32 = 0,

    /// The minimum answer value.
    min_value: i32 = 0,

    /// The scoring options of the numeric question.
    options: ?[]const EvaluationFormNumericQuestionOption,

    pub const json_field_names = .{
        .automation = "Automation",
        .max_value = "MaxValue",
        .min_value = "MinValue",
        .options = "Options",
    };
};
