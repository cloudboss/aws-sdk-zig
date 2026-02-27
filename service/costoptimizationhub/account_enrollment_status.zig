const EnrollmentStatus = @import("enrollment_status.zig").EnrollmentStatus;

/// Describes the enrollment status of an organization's member accounts in Cost
/// Optimization Hub.
pub const AccountEnrollmentStatus = struct {
    /// The Amazon Web Services account ID.
    account_id: ?[]const u8,

    /// The time when the account enrollment status was created.
    created_timestamp: ?i64,

    /// The time when the account enrollment status was last updated.
    last_updated_timestamp: ?i64,

    /// The account enrollment status.
    status: ?EnrollmentStatus,

    pub const json_field_names = .{
        .account_id = "accountId",
        .created_timestamp = "createdTimestamp",
        .last_updated_timestamp = "lastUpdatedTimestamp",
        .status = "status",
    };
};
