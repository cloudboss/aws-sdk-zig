/// Contains configuration details for the protected query member output.
pub const ProtectedQueryMemberOutputConfiguration = struct {
    /// The unique identifier for the account.
    account_id: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
    };
};
