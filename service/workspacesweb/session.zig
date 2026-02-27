const SessionStatus = @import("session_status.zig").SessionStatus;

/// Information about a secure browser session.
pub const Session = struct {
    /// The IP address of the client.
    client_ip_addresses: ?[]const []const u8,

    /// The end time of the session.
    end_time: ?i64,

    /// The ARN of the web portal.
    portal_arn: ?[]const u8,

    /// The ID of the session.
    session_id: ?[]const u8,

    /// The start time of the session.
    start_time: ?i64,

    /// The status of the session.
    status: ?SessionStatus,

    /// The username of the session.
    username: ?[]const u8,

    pub const json_field_names = .{
        .client_ip_addresses = "clientIpAddresses",
        .end_time = "endTime",
        .portal_arn = "portalArn",
        .session_id = "sessionId",
        .start_time = "startTime",
        .status = "status",
        .username = "username",
    };
};
