/// AWS account.
pub const Account = struct {
    /// Account ID of AWS account.
    account_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountID",
    };
};
