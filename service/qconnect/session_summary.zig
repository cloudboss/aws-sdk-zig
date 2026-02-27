/// Summary information about the session.
pub const SessionSummary = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Q in Connect assistant.
    assistant_arn: []const u8,

    /// The identifier of the Amazon Q in Connect assistant.
    assistant_id: []const u8,

    /// The Amazon Resource Name (ARN) of the session.
    session_arn: []const u8,

    /// The identifier of the session.
    session_id: []const u8,

    pub const json_field_names = .{
        .assistant_arn = "assistantArn",
        .assistant_id = "assistantId",
        .session_arn = "sessionArn",
        .session_id = "sessionId",
    };
};
