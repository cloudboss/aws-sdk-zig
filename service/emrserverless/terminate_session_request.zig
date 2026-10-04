pub const TerminateSessionRequest = struct {
    /// The ID of the application that the session belongs to.
    application_id: []const u8,

    /// The ID of the session to terminate.
    session_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .session_id = "sessionId",
    };
};
