/// Contains information about the account.
pub const AccountDetail = struct {
    /// The member account ID.
    account_id: []const u8,

    /// The email address of the member account. The following list includes the
    /// rules for a valid email address:
    ///
    /// * The email address must be a minimum of 6 and a maximum of 64 characters
    ///   long.
    ///
    /// * All characters must be 7-bit ASCII characters.
    ///
    /// * There must be one and only one @ symbol, which separates the local name
    ///   from the domain name.
    ///
    /// * The local name can't contain any of the following characters:
    ///
    /// whitespace, " ' ( ) [ ] : ' , \ | % &
    ///
    /// * The local name can't begin with a dot (.).
    ///
    /// * The domain name can consist of only the characters [a-z], [A-Z], [0-9],
    ///   hyphen (-), or dot (.).
    ///
    /// * The domain name can't begin or end with a dot (.) or hyphen (-).
    ///
    /// * The domain name must contain at least one dot.
    email: []const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .email = "Email",
    };
};
