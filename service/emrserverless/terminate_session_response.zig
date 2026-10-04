pub const TerminateSessionResponse = struct {
    /// The output contains the application ID on which the session was terminated.
    application_id: []const u8,

    /// The output contains the ID of the terminated session.
    session_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .session_id = "sessionId",
    };
};
