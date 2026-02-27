/// Describes the credentials for the service account used by the fleet or image
/// builder to connect to the directory.
pub const ServiceAccountCredentials = struct {
    /// The user name of the account. This account must have the following
    /// privileges: create computer objects,
    /// join computers to the domain, and change/reset the password on descendant
    /// computer objects for the
    /// organizational units specified.
    account_name: []const u8,

    /// The password for the account.
    account_password: []const u8,

    pub const json_field_names = .{
        .account_name = "AccountName",
        .account_password = "AccountPassword",
    };
};
