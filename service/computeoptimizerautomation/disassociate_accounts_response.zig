pub const DisassociateAccountsResponse = struct {
    /// The IDs of the member accounts that were successfully disassociated.
    account_ids: ?[]const []const u8,

    /// Any errors that occurred during the disassociation process.
    errors: ?[]const []const u8,

    pub const json_field_names = .{
        .account_ids = "accountIds",
        .errors = "errors",
    };
};
