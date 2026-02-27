const EvaluationAnswerData = @import("evaluation_answer_data.zig").EvaluationAnswerData;

/// Information about input answers for a contact evaluation.
pub const EvaluationAnswerInput = struct {
    /// The value for an answer in a contact evaluation.
    value: ?EvaluationAnswerData,

    pub const json_field_names = .{
        .value = "Value",
    };
};
