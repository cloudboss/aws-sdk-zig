pub const DisassociateAccountsRequest = struct {
    /// The IDs of the member accounts to disassociate.
    account_ids: []const []const u8,

    /// A unique identifier to ensure idempotency of the request.
    client_token: ?[]const u8,

    pub const json_field_names = .{
        .account_ids = "accountIds",
        .client_token = "clientToken",
    };
};
