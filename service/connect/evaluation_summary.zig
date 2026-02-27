const EvaluationAcknowledgementSummary = @import("evaluation_acknowledgement_summary.zig").EvaluationAcknowledgementSummary;
const AutoEvaluationStatus = @import("auto_evaluation_status.zig").AutoEvaluationStatus;
const EvaluationContactParticipant = @import("evaluation_contact_participant.zig").EvaluationContactParticipant;
const EvaluationType = @import("evaluation_type.zig").EvaluationType;
const EvaluationScore = @import("evaluation_score.zig").EvaluationScore;
const EvaluationStatus = @import("evaluation_status.zig").EvaluationStatus;

/// Summary information about a contact evaluation.
pub const EvaluationSummary = struct {
    /// Information related to evaluation acknowledgement.
    acknowledgement: ?EvaluationAcknowledgementSummary,

    /// Whether automated evaluation is enabled.
    auto_evaluation_enabled: bool = false,

    /// The status of the contact auto evaluation.
    auto_evaluation_status: ?AutoEvaluationStatus,

    /// The calibration session ID that this evaluation belongs to.
    calibration_session_id: ?[]const u8,

    /// Information about a contact participant in the evaluation.
    contact_participant: ?EvaluationContactParticipant,

    /// The timestamp for when the evaluation was created.
    created_time: i64,

    /// The Amazon Resource Name (ARN) for the contact evaluation resource.
    evaluation_arn: []const u8,

    /// The unique identifier for the evaluation form.
    evaluation_form_id: []const u8,

    /// A title of the evaluation form.
    evaluation_form_title: []const u8,

    /// A unique identifier for the contact evaluation.
    evaluation_id: []const u8,

    /// Type of the evaluation.
    evaluation_type: ?EvaluationType,

    /// The Amazon Resource Name (ARN) of the user who last updated the evaluation.
    evaluator_arn: []const u8,

    /// The timestamp for when the evaluation was last updated.
    last_modified_time: i64,

    /// The overall score of the contact evaluation.
    score: ?EvaluationScore,

    /// The status of the contact evaluation.
    status: EvaluationStatus,

    pub const json_field_names = .{
        .acknowledgement = "Acknowledgement",
        .auto_evaluation_enabled = "AutoEvaluationEnabled",
        .auto_evaluation_status = "AutoEvaluationStatus",
        .calibration_session_id = "CalibrationSessionId",
        .contact_participant = "ContactParticipant",
        .created_time = "CreatedTime",
        .evaluation_arn = "EvaluationArn",
        .evaluation_form_id = "EvaluationFormId",
        .evaluation_form_title = "EvaluationFormTitle",
        .evaluation_id = "EvaluationId",
        .evaluation_type = "EvaluationType",
        .evaluator_arn = "EvaluatorArn",
        .last_modified_time = "LastModifiedTime",
        .score = "Score",
        .status = "Status",
    };
};
