const EvaluationFormQuestion = @import("evaluation_form_question.zig").EvaluationFormQuestion;
const EvaluationFormSection = @import("evaluation_form_section.zig").EvaluationFormSection;

/// Information about an item from an evaluation form. The item must be either a
/// section or a question.
pub const EvaluationFormItem = union(enum) {
    /// The information of the question.
    question: ?EvaluationFormQuestion,
    /// The information of the section.
    section: ?EvaluationFormSection,

    pub const json_field_names = .{
        .question = "Question",
        .section = "Section",
    };
};
