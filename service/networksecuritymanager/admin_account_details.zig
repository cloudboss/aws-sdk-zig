const AdminScope = @import("admin_scope.zig").AdminScope;
const AdminAccountStatus = @import("admin_account_status.zig").AdminAccountStatus;

/// The details of an AWS Network Security Manager administrator account.
pub const AdminAccountDetails = struct {
    /// The AWS account ID of the administrator account.
    admin_account: []const u8,

    /// The administrative scope, which defines the accounts, organizational units,
    /// and firewall types that the administrator can manage.
    admin_scope: ?AdminScope = null,

    /// The priority assigned to the administrator account.
    priority: i32,

    /// The status of the administrator account, either `ONBOARDED` or `OFFBOARDED`.
    status: ?AdminAccountStatus = null,

    pub const json_field_names = .{
        .admin_account = "adminAccount",
        .admin_scope = "adminScope",
        .priority = "priority",
        .status = "status",
    };
};
