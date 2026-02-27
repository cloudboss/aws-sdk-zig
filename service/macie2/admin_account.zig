const AdminStatus = @import("admin_status.zig").AdminStatus;

/// Provides information about the delegated Amazon Macie administrator account
/// for an organization in Organizations.
pub const AdminAccount = struct {
    /// The Amazon Web Services account ID for the account.
    account_id: ?[]const u8,

    /// The current status of the account as the delegated Amazon Macie
    /// administrator account for the organization.
    status: ?AdminStatus,

    pub const json_field_names = .{
        .account_id = "accountId",
        .status = "status",
    };
};
