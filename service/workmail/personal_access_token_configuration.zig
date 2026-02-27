const PersonalAccessTokenConfigurationStatus = @import("personal_access_token_configuration_status.zig").PersonalAccessTokenConfigurationStatus;

/// Displays the Personal Access Token status.
pub const PersonalAccessTokenConfiguration = struct {
    /// The validity of the Personal Access Token status in days.
    lifetime_in_days: ?i32,

    /// The status of the Personal Access Token allowed for the organization.
    ///
    /// * *Active* - Mailbox users can login to the web application and choose
    ///   *Settings* to see the new *Personal Access Tokens* page to
    /// create and delete the Personal Access Tokens. Mailbox users can use the
    /// Personal Access Tokens to set up mailbox connection from desktop or mobile
    /// email clients.
    ///
    /// * *Inactive* - Personal Access Tokens are disabled for your organization.
    ///   Mailbox users can’t create, list, or delete Personal Access Tokens and
    ///   can’t use them to connect to
    /// their mailboxes from desktop or mobile email clients.
    status: PersonalAccessTokenConfigurationStatus,

    pub const json_field_names = .{
        .lifetime_in_days = "LifetimeInDays",
        .status = "Status",
    };
};
