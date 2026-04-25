const SessionState = @import("session_state.zig").SessionState;

/// The summary of attributes associated with a session.
pub const SessionSummary = struct {
    /// The ID of the application that the session belongs to.
    application_id: []const u8,

    /// The Amazon Resource Name (ARN) of the session.
    arn: []const u8,

    /// The date and time that the session was created.
    created_at: i64,

    /// The IAM principal that created the session.
    created_by: []const u8,

    /// The Amazon Resource Name (ARN) of the execution role for the session.
    execution_role_arn: []const u8,

    /// The optional name of the session.
    name: ?[]const u8 = null,

    /// The Amazon EMR release label associated with the session.
    release_label: []const u8,

    /// The ID of the session.
    session_id: []const u8,

    /// The state of the session.
    state: SessionState,

    /// Additional details about the current state of the session.
    state_details: []const u8,

    /// The date and time that the session was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .arn = "arn",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .execution_role_arn = "executionRoleArn",
        .name = "name",
        .release_label = "releaseLabel",
        .session_id = "sessionId",
        .state = "state",
        .state_details = "stateDetails",
        .updated_at = "updatedAt",
    };
};
