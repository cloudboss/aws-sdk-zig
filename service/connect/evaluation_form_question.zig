const EvaluationFormItemEnablementConfiguration = @import("evaluation_form_item_enablement_configuration.zig").EvaluationFormItemEnablementConfiguration;
const EvaluationFormQuestionType = @import("evaluation_form_question_type.zig").EvaluationFormQuestionType;
const EvaluationFormQuestionTypeProperties = @import("evaluation_form_question_type_properties.zig").EvaluationFormQuestionTypeProperties;

/// Information about a question from an evaluation form.
pub const EvaluationFormQuestion = struct {
    /// A question conditional enablement.
    enablement: ?EvaluationFormItemEnablementConfiguration = null,

    /// The instructions of the section.
    instructions: ?[]const u8 = null,

    /// The flag to enable not applicable answers to the question.
    not_applicable_enabled: bool = false,

    /// The type of the question.
    question_type: EvaluationFormQuestionType,

    /// The properties of the type of question. Text questions do not have to define
    /// question type properties.
    question_type_properties: ?EvaluationFormQuestionTypeProperties = null,

    /// The identifier of the question. An identifier must be unique within the
    /// evaluation form.
    ref_id: []const u8,

    /// The title of the question.
    title: []const u8,

    /// The scoring weight of the section.
    weight: f64 = 0,

    pub const json_field_names = .{
        .enablement = "Enablement",
        .instructions = "Instructions",
        .not_applicable_enabled = "NotApplicableEnabled",
        .question_type = "QuestionType",
        .question_type_properties = "QuestionTypeProperties",
        .ref_id = "RefId",
        .title = "Title",
        .weight = "Weight",
    };
};
