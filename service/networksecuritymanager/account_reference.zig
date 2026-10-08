/// A reference to an AWS account, with optional display metadata.
pub const AccountReference = struct {
    /// The AWS account ID.
    account_id: []const u8,

    /// The email address associated with the account.
    email: ?[]const u8 = null,

    /// The display name of the account.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .email = "email",
        .name = "name",
    };
};
