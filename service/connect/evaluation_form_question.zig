const EvaluationFormItemEnablementConfiguration = @import("evaluation_form_item_enablement_configuration.zig").EvaluationFormItemEnablementConfiguration;
const EvaluationFormMetricConfiguration = @import("evaluation_form_metric_configuration.zig").EvaluationFormMetricConfiguration;
const EvaluationFormQuestionType = @import("evaluation_form_question_type.zig").EvaluationFormQuestionType;
const EvaluationFormQuestionTypeProperties = @import("evaluation_form_question_type_properties.zig").EvaluationFormQuestionTypeProperties;
const EvaluationFormQuestionScoringConfiguration = @import("evaluation_form_question_scoring_configuration.zig").EvaluationFormQuestionScoringConfiguration;

/// Information about a question from an evaluation form.
pub const EvaluationFormQuestion = struct {
    /// A question conditional enablement.
    enablement: ?EvaluationFormItemEnablementConfiguration = null,

    /// The instructions of the section.
    instructions: ?[]const u8 = null,

    /// The metric configuration for the question. Use this to associate a business
    /// outcome metric with the
    /// question.
    metric_configuration: ?EvaluationFormMetricConfiguration = null,

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

    /// The scoring configuration of the question.
    scoring_configuration: ?EvaluationFormQuestionScoringConfiguration = null,

    /// The title of the question.
    title: []const u8,

    /// The scoring weight of the section.
    weight: f64 = 0,

    pub const json_field_names = .{
        .enablement = "Enablement",
        .instructions = "Instructions",
        .metric_configuration = "MetricConfiguration",
        .not_applicable_enabled = "NotApplicableEnabled",
        .question_type = "QuestionType",
        .question_type_properties = "QuestionTypeProperties",
        .ref_id = "RefId",
        .scoring_configuration = "ScoringConfiguration",
        .title = "Title",
        .weight = "Weight",
    };
};
