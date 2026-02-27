/// The details of an Amazon Web Services account.
pub const AccountDetails = struct {
    /// The ID of an Amazon Web Services account.
    account_id: []const u8,

    /// The email of an Amazon Web Services account.
    email: ?[]const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .email = "Email",
    };
};
