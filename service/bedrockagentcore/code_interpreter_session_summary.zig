const CodeInterpreterSessionStatus = @import("code_interpreter_session_status.zig").CodeInterpreterSessionStatus;

/// A condensed representation of a code interpreter session in Amazon Bedrock
/// AgentCore. This structure contains key information about a code interpreter
/// session, including identifiers, status, and timestamps, without the full
/// details of the session configuration.
pub const CodeInterpreterSessionSummary = struct {
    /// The unique identifier of the code interpreter associated with the session.
    /// This identifier specifies which code interpreter environment is used for the
    /// session.
    code_interpreter_identifier: []const u8,

    /// The timestamp when the code interpreter session was created. This value is
    /// in ISO 8601 format.
    created_at: i64,

    /// The timestamp when the code interpreter session was last updated. This value
    /// is in ISO 8601 format.
    last_updated_at: ?i64,

    /// The name of the code interpreter session. This name helps identify and
    /// manage the session.
    name: ?[]const u8,

    /// The unique identifier of the code interpreter session. This identifier is
    /// used in operations that interact with the session.
    session_id: []const u8,

    /// The current status of the code interpreter session. Possible values include
    /// ACTIVE, STOPPING, and STOPPED.
    status: CodeInterpreterSessionStatus,

    pub const json_field_names = .{
        .code_interpreter_identifier = "codeInterpreterIdentifier",
        .created_at = "createdAt",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .session_id = "sessionId",
        .status = "status",
    };
};
