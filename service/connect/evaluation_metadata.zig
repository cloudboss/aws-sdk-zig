const EvaluationAcknowledgement = @import("evaluation_acknowledgement.zig").EvaluationAcknowledgement;
const AutoEvaluationDetails = @import("auto_evaluation_details.zig").AutoEvaluationDetails;
const EvaluationContactParticipant = @import("evaluation_contact_participant.zig").EvaluationContactParticipant;
const EvaluationReviewMetadata = @import("evaluation_review_metadata.zig").EvaluationReviewMetadata;
const EvaluationScore = @import("evaluation_score.zig").EvaluationScore;

/// Metadata information about a contact evaluation.
pub const EvaluationMetadata = struct {
    /// Information related to evaluation acknowledgement.
    acknowledgement: ?EvaluationAcknowledgement,

    /// Information related to automated evaluation.
    auto_evaluation: ?AutoEvaluationDetails,

    /// The calibration session ID that this evaluation belongs to.
    calibration_session_id: ?[]const u8,

    /// The identifier of the agent who performed the contact.
    contact_agent_id: ?[]const u8,

    /// The identifier of the contact in this instance of Amazon Connect.
    contact_id: []const u8,

    /// Information about a contact participant in this evaluation.
    contact_participant: ?EvaluationContactParticipant,

    /// The Amazon Resource Name (ARN) of the user who last updated the evaluation.
    evaluator_arn: []const u8,

    /// Information about reviews of this evaluation.
    review: ?EvaluationReviewMetadata,

    /// Identifier of the sampling job.
    sampling_job_id: ?[]const u8,

    /// The overall score of the contact evaluation.
    score: ?EvaluationScore,

    pub const json_field_names = .{
        .acknowledgement = "Acknowledgement",
        .auto_evaluation = "AutoEvaluation",
        .calibration_session_id = "CalibrationSessionId",
        .contact_agent_id = "ContactAgentId",
        .contact_id = "ContactId",
        .contact_participant = "ContactParticipant",
        .evaluator_arn = "EvaluatorArn",
        .review = "Review",
        .sampling_job_id = "SamplingJobId",
        .score = "Score",
    };
};
