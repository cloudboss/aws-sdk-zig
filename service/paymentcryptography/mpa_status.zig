const SessionStatus = @import("session_status.zig").SessionStatus;

/// The status of an MPA session.
pub const MpaStatus = struct {
    /// The date and time when the MPA session was initiated.
    initiation_date: i64,

    /// The ARN of the MPA session.
    mpa_session_arn: []const u8,

    /// The current status of the MPA session.
    status: SessionStatus,

    /// The message providing additional information about the MPA session status.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .initiation_date = "InitiationDate",
        .mpa_session_arn = "MpaSessionArn",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
