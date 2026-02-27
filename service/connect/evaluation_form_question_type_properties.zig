const EvaluationFormMultiSelectQuestionProperties = @import("evaluation_form_multi_select_question_properties.zig").EvaluationFormMultiSelectQuestionProperties;
const EvaluationFormNumericQuestionProperties = @import("evaluation_form_numeric_question_properties.zig").EvaluationFormNumericQuestionProperties;
const EvaluationFormSingleSelectQuestionProperties = @import("evaluation_form_single_select_question_properties.zig").EvaluationFormSingleSelectQuestionProperties;
const EvaluationFormTextQuestionProperties = @import("evaluation_form_text_question_properties.zig").EvaluationFormTextQuestionProperties;

/// Information about properties for a question in an evaluation form. The
/// question type properties must be either
/// for a numeric question or a single select question.
pub const EvaluationFormQuestionTypeProperties = union(enum) {
    /// Properties for multi-select question types.
    multi_select: ?EvaluationFormMultiSelectQuestionProperties,
    /// The properties of the numeric question.
    numeric: ?EvaluationFormNumericQuestionProperties,
    /// The properties of the numeric question.
    single_select: ?EvaluationFormSingleSelectQuestionProperties,
    /// The properties of the text question.
    text: ?EvaluationFormTextQuestionProperties,

    pub const json_field_names = .{
        .multi_select = "MultiSelect",
        .numeric = "Numeric",
        .single_select = "SingleSelect",
        .text = "Text",
    };
};
