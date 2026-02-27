/// Summary information about an evaluation acknowledgement.
pub const EvaluationAcknowledgementSummary = struct {
    /// The agent who acknowledged the evaluation.
    acknowledged_by: ?[]const u8,

    /// The time when an agent acknowledged the evaluation.
    acknowledged_time: ?i64,

    /// A comment from the agent when they confirmed they acknowledged the
    /// evaluation.
    acknowledger_comment: ?[]const u8,

    pub const json_field_names = .{
        .acknowledged_by = "AcknowledgedBy",
        .acknowledged_time = "AcknowledgedTime",
        .acknowledger_comment = "AcknowledgerComment",
    };
};
