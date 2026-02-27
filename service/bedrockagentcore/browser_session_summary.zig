const BrowserSessionStatus = @import("browser_session_status.zig").BrowserSessionStatus;

/// A condensed representation of a browser session in Amazon Bedrock AgentCore.
/// This structure contains key information about a browser session, including
/// identifiers, status, and timestamps, without the full details of the session
/// configuration and streams.
pub const BrowserSessionSummary = struct {
    /// The unique identifier of the browser associated with the session. This
    /// identifier specifies which browser environment is used for the session.
    browser_identifier: []const u8,

    /// The timestamp when the browser session was created. This value is in ISO
    /// 8601 format.
    created_at: i64,

    /// The timestamp when the browser session was last updated. This value is in
    /// ISO 8601 format.
    last_updated_at: ?i64,

    /// The name of the browser session. This name helps identify and manage the
    /// session.
    name: ?[]const u8,

    /// The unique identifier of the browser session. This identifier is used in
    /// operations that interact with the session.
    session_id: []const u8,

    /// The current status of the browser session. Possible values include ACTIVE,
    /// STOPPING, and STOPPED.
    status: BrowserSessionStatus,

    pub const json_field_names = .{
        .browser_identifier = "browserIdentifier",
        .created_at = "createdAt",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .session_id = "sessionId",
        .status = "status",
    };
};
