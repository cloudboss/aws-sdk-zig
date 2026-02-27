/// Specifies the details of an account to associate with an Amazon Macie
/// administrator account.
pub const AccountDetail = struct {
    /// The Amazon Web Services account ID for the account.
    account_id: []const u8,

    /// The email address for the account.
    email: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .email = "email",
    };
};
