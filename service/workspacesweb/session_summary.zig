const SessionStatus = @import("session_status.zig").SessionStatus;

/// Summary information about a secure browser session.
pub const SessionSummary = struct {
    /// The end time of the session.
    end_time: ?i64 = null,

    /// The ARN of the web portal.
    portal_arn: ?[]const u8 = null,

    /// The ID of the session.
    session_id: ?[]const u8 = null,

    /// The start time of the session.
    start_time: ?i64 = null,

    /// The status of the session.
    status: ?SessionStatus = null,

    /// The username of the session.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .end_time = "endTime",
        .portal_arn = "portalArn",
        .session_id = "sessionId",
        .start_time = "startTime",
        .status = "status",
        .username = "username",
    };
};
