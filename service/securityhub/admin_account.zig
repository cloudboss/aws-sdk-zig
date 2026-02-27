const AdminStatus = @import("admin_status.zig").AdminStatus;

/// Represents a Security Hub administrator account designated by an
/// organization management
/// account.
pub const AdminAccount = struct {
    /// The Amazon Web Services account identifier of the Security Hub administrator
    /// account.
    account_id: ?[]const u8,

    /// The current status of the Security Hub administrator account. Indicates
    /// whether the account is
    /// currently enabled as a Security Hub administrator.
    status: ?AdminStatus,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .status = "Status",
    };
};
