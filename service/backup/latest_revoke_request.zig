const MpaRevokeSessionStatus = @import("mpa_revoke_session_status.zig").MpaRevokeSessionStatus;

/// Contains information about the latest request to revoke access to a backup
/// vault.
pub const LatestRevokeRequest = struct {
    /// The date and time when the revoke request will expire.
    expiry_date: ?i64,

    /// The date and time when the revoke request was initiated.
    initiation_date: ?i64,

    /// The ARN of the MPA session associated with this revoke request.
    mpa_session_arn: ?[]const u8,

    /// The current status of the revoke request.
    status: ?MpaRevokeSessionStatus,

    /// A message describing the current status of the revoke request.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .expiry_date = "ExpiryDate",
        .initiation_date = "InitiationDate",
        .mpa_session_arn = "MpaSessionArn",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
