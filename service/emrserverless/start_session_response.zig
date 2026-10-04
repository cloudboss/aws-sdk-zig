pub const StartSessionResponse = struct {
    /// The output contains the application ID on which the session was started.
    application_id: []const u8,

    /// The output contains the ARN of the session.
    arn: []const u8,

    /// The output contains the ID of the session.
    session_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .arn = "arn",
        .session_id = "sessionId",
    };
};
