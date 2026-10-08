/// Summary information about an AWS Network Security Manager administrator
/// account.
pub const AdminAccountSummary = struct {
    /// The AWS account ID.
    account_id: []const u8,

    /// The email address associated with the account.
    email: ?[]const u8 = null,

    /// The name of the administrator account.
    name: ?[]const u8 = null,

    /// The priority assigned to the administrator account.
    priority: ?i32 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .email = "email",
        .name = "name",
        .priority = "priority",
    };
};
