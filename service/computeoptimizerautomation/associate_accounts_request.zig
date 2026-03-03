pub const AssociateAccountsRequest = struct {
    /// The IDs of the member accounts to associate. You can specify up to 50
    /// account IDs.
    account_ids: []const []const u8,

    /// A unique identifier to ensure idempotency of the request. Valid for 24 hours
    /// after creation.
    client_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_ids = "accountIds",
        .client_token = "clientToken",
    };
};
