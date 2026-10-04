/// A session associated with an execution summary cluster.
pub const ExecutionSummaryAffectedSession = struct {
    /// The approach taken by the agent during this session.
    approach_taken: []const u8,

    /// The final outcome of the session.
    final_outcome: []const u8,

    /// The unique identifier of the session.
    session_id: []const u8,

    pub const json_field_names = .{
        .approach_taken = "approachTaken",
        .final_outcome = "finalOutcome",
        .session_id = "sessionId",
    };
};
