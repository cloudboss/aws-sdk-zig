/// Information about the evaluation acknowledgement.
pub const EvaluationAcknowledgement = struct {
    /// The agent who acknowledged the evaluation.
    acknowledged_by: []const u8,

    /// When the agent acknowledged the evaluation.
    acknowledged_time: i64,

    /// A comment from the agent when they confirmed they acknowledged the
    /// evaluation.
    acknowledger_comment: ?[]const u8 = null,

    pub const json_field_names = .{
        .acknowledged_by = "AcknowledgedBy",
        .acknowledged_time = "AcknowledgedTime",
        .acknowledger_comment = "AcknowledgerComment",
    };
};
