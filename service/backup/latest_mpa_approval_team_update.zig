const MpaSessionStatus = @import("mpa_session_status.zig").MpaSessionStatus;

/// Contains information about the latest update to an MPA approval team
/// association.
pub const LatestMpaApprovalTeamUpdate = struct {
    /// The date and time when the MPA approval team update will expire.
    expiry_date: ?i64,

    /// The date and time when the MPA approval team update was initiated.
    initiation_date: ?i64,

    /// The ARN of the MPA session associated with this update.
    mpa_session_arn: ?[]const u8,

    /// The current status of the MPA approval team update.
    status: ?MpaSessionStatus,

    /// A message describing the current status of the MPA approval team update.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .expiry_date = "ExpiryDate",
        .initiation_date = "InitiationDate",
        .mpa_session_arn = "MpaSessionArn",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
