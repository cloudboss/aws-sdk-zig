/// Contains information about the accounts that weren't processed.
pub const UnprocessedAccount = struct {
    /// The Amazon Web Services account ID.
    account_id: []const u8,

    /// A reason why the account hasn't been processed.
    result: []const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .result = "Result",
    };
};
