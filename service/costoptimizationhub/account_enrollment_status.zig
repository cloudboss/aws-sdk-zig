const EnrollmentStatus = @import("enrollment_status.zig").EnrollmentStatus;

/// Describes the enrollment status of an organization's member accounts in Cost
/// Optimization Hub.
pub const AccountEnrollmentStatus = struct {
    /// The Amazon Web Services account ID.
    account_id: ?[]const u8 = null,

    /// The time when the account enrollment status was created.
    created_timestamp: ?i64 = null,

    /// The time when the account enrollment status was last updated.
    last_updated_timestamp: ?i64 = null,

    /// The account enrollment status.
    status: ?EnrollmentStatus = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .created_timestamp = "createdTimestamp",
        .last_updated_timestamp = "lastUpdatedTimestamp",
        .status = "status",
    };
};
