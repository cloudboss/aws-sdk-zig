/// An Amazon Web Services account that is the administrator account of or a
/// member of a
/// behavior graph.
pub const Account = struct {
    /// The account identifier of the Amazon Web Services account.
    account_id: []const u8,

    /// The Amazon Web Services account root user email address for the Amazon Web
    /// Services
    /// account.
    email_address: []const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .email_address = "EmailAddress",
    };
};
