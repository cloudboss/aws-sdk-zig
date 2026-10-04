/// A reference to an insight analysis to run against sessions during
/// evaluation. Insights provide deeper analysis beyond individual evaluator
/// scores, including failure detection, user intent clustering, and execution
/// summarization.
pub const Insight = struct {
    /// The unique identifier of the insight to run.
    insight_id: []const u8,

    pub const json_field_names = .{
        .insight_id = "insightId",
    };
};
