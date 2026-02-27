/// Summary information about a session within a workflow run.
pub const SessionSummary = struct {
    /// The unique identifier of the session.
    session_id: []const u8,

    pub const json_field_names = .{
        .session_id = "sessionId",
    };
};
