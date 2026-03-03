pub const AssociateAccountsResponse = struct {
    /// The IDs of the member accounts that were successfully associated.
    account_ids: ?[]const []const u8 = null,

    /// Any errors that occurred during the association process.
    errors: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .account_ids = "accountIds",
        .errors = "errors",
    };
};
