const UserRole = @import("user_role.zig").UserRole;
const SelfUpgradeRequestStatus = @import("self_upgrade_request_status.zig").SelfUpgradeRequestStatus;

/// Details of a self-upgrade request.
pub const SelfUpgradeRequestDetail = struct {
    /// The time when the self-upgrade request was created.
    creation_time: i64 = 0,

    /// The time of the last update attempt for the self-upgrade request.
    last_update_attempt_time: i64 = 0,

    /// The reason for the last update failure, if applicable.
    last_update_failure_reason: ?[]const u8 = null,

    /// The original role of the user before the upgrade.
    original_role: ?UserRole = null,

    /// The role that the user is requesting to upgrade to.
    requested_role: ?UserRole = null,

    /// An optional note explaining the reason for the self-upgrade request.
    request_note: ?[]const u8 = null,

    /// The status of the self-upgrade request.
    request_status: ?SelfUpgradeRequestStatus = null,

    /// The ID of the self-upgrade request.
    upgrade_request_id: ?[]const u8 = null,

    /// The username of the user who initiated the self-upgrade request.
    user_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .last_update_attempt_time = "lastUpdateAttemptTime",
        .last_update_failure_reason = "lastUpdateFailureReason",
        .original_role = "OriginalRole",
        .requested_role = "RequestedRole",
        .request_note = "RequestNote",
        .request_status = "RequestStatus",
        .upgrade_request_id = "UpgradeRequestId",
        .user_name = "UserName",
    };
};
