const AdminStatus = @import("admin_status.zig").AdminStatus;

/// The account within the organization specified as the GuardDuty delegated
/// administrator.
pub const AdminAccount = struct {
    /// The Amazon Web Services account ID for the account.
    admin_account_id: ?[]const u8,

    /// Indicates whether the account is enabled as the delegated administrator.
    admin_status: ?AdminStatus,

    pub const json_field_names = .{
        .admin_account_id = "AdminAccountId",
        .admin_status = "AdminStatus",
    };
};
