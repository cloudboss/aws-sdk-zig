const Status = @import("status.zig").Status;

/// Describes the enrollment status of an organization's member accounts in
/// Compute Optimizer.
pub const AccountEnrollmentStatus = struct {
    /// The Amazon Web Services account ID.
    account_id: ?[]const u8 = null,

    /// The Unix epoch timestamp, in seconds, of when the account enrollment status
    /// was last
    /// updated.
    last_updated_timestamp: ?i64 = null,

    /// The account enrollment status.
    status: ?Status = null,

    /// The reason for the account enrollment status.
    ///
    /// For example, an account might show a status of `Pending` because member
    /// accounts of an organization require more time to be enrolled in the service.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .last_updated_timestamp = "lastUpdatedTimestamp",
        .status = "status",
        .status_reason = "statusReason",
    };
};
