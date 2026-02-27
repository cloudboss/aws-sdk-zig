const AutoEvaluationStatus = @import("auto_evaluation_status.zig").AutoEvaluationStatus;
const ContactParticipantRole = @import("contact_participant_role.zig").ContactParticipantRole;

/// Metadata information about an evaluation search.
pub const EvaluationSearchMetadata = struct {
    /// The agent who acknowledged the evaluation.
    acknowledged_by: ?[]const u8,

    /// When the evaluation was acknowledged by the agent.
    acknowledged_time: ?i64,

    /// The comment from the agent when they acknowledged the evaluation.
    acknowledger_comment: ?[]const u8,

    /// Whether auto-evaluation is enabled.
    auto_evaluation_enabled: bool = false,

    /// The status of the contact auto evaluation.
    auto_evaluation_status: ?AutoEvaluationStatus,

    /// The calibration session ID that this evaluation belongs to.
    calibration_session_id: ?[]const u8,

    /// The unique ID of the agent who handled the contact.
    contact_agent_id: ?[]const u8,

    /// The identifier of the contact in this instance of Amazon Connect.
    contact_id: []const u8,

    /// Identifier for a contact participant in the evaluation.
    contact_participant_id: ?[]const u8,

    /// Role of a contact participant in the evaluation.
    contact_participant_role: ?ContactParticipantRole,

    /// The Amazon Resource Name (ARN) of the person who evaluated the contact.
    evaluator_arn: []const u8,

    /// Identifier for the review.
    review_id: ?[]const u8,

    /// Identifier of the sampling job.
    sampling_job_id: ?[]const u8,

    /// The flag that marks the item as automatic fail. If the item or a child item
    /// gets an automatic fail answer, this
    /// flag is true.
    score_automatic_fail: bool = false,

    /// The flag to mark the item as not applicable for scoring.
    score_not_applicable: bool = false,

    /// The total evaluation score expressed as a percentage.
    score_percentage: f64 = 0,

    pub const json_field_names = .{
        .acknowledged_by = "AcknowledgedBy",
        .acknowledged_time = "AcknowledgedTime",
        .acknowledger_comment = "AcknowledgerComment",
        .auto_evaluation_enabled = "AutoEvaluationEnabled",
        .auto_evaluation_status = "AutoEvaluationStatus",
        .calibration_session_id = "CalibrationSessionId",
        .contact_agent_id = "ContactAgentId",
        .contact_id = "ContactId",
        .contact_participant_id = "ContactParticipantId",
        .contact_participant_role = "ContactParticipantRole",
        .evaluator_arn = "EvaluatorArn",
        .review_id = "ReviewId",
        .sampling_job_id = "SamplingJobId",
        .score_automatic_fail = "ScoreAutomaticFail",
        .score_not_applicable = "ScoreNotApplicable",
        .score_percentage = "ScorePercentage",
    };
};
