const EvaluationSuggestedAnswer = @import("evaluation_suggested_answer.zig").EvaluationSuggestedAnswer;
const EvaluationAnswerData = @import("evaluation_answer_data.zig").EvaluationAnswerData;

/// Information about output answers for a contact evaluation.
pub const EvaluationAnswerOutput = struct {
    /// Automation suggested answers for the questions.
    suggested_answers: ?[]const EvaluationSuggestedAnswer = null,

    /// The system suggested value for an answer in a contact evaluation.
    system_suggested_value: ?EvaluationAnswerData = null,

    /// The value for an answer in a contact evaluation.
    value: ?EvaluationAnswerData = null,

    pub const json_field_names = .{
        .suggested_answers = "SuggestedAnswers",
        .system_suggested_value = "SystemSuggestedValue",
        .value = "Value",
    };
};
