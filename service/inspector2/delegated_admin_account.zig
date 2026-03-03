const DelegatedAdminStatus = @import("delegated_admin_status.zig").DelegatedAdminStatus;

/// Details of the Amazon Inspector delegated administrator for your
/// organization.
pub const DelegatedAdminAccount = struct {
    /// The Amazon Web Services account ID of the Amazon Inspector delegated
    /// administrator for your organization.
    account_id: ?[]const u8 = null,

    /// The status of the Amazon Inspector delegated administrator.
    status: ?DelegatedAdminStatus = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .status = "status",
    };
};
