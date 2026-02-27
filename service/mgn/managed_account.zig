/// Managed account.
pub const ManagedAccount = struct {
    /// Managed account, account ID.
    account_id: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
    };
};
