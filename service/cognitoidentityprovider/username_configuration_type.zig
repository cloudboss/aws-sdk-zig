/// The configuration of a user pool for username case sensitivity.
pub const UsernameConfigurationType = struct {
    /// Specifies whether user name case sensitivity will be applied for all users
    /// in the user
    /// pool through Amazon Cognito APIs. For most use cases, set case sensitivity
    /// to `False`
    /// (case insensitive) as a best practice. When usernames and email addresses
    /// are case
    /// insensitive, users can sign in as the same user when they enter a different
    /// capitalization of their user name.
    ///
    /// Valid values include:
    ///
    /// **true**
    ///
    /// Enables case sensitivity for all username input. When this option is set
    /// to `true`, users must sign in using the exact capitalization of
    /// their given username, such as “UserName”. This is the default value.
    ///
    /// **false**
    ///
    /// Enables case insensitivity for all username input. For example, when this
    /// option is set to `false`, users can sign in using
    /// `username`, `USERNAME`, or `UserName`.
    /// This option also enables both `preferred_username` and
    /// `email` alias to be case insensitive, in addition to the
    /// `username` attribute.
    case_sensitive: bool,

    pub const json_field_names = .{
        .case_sensitive = "CaseSensitive",
    };
};
