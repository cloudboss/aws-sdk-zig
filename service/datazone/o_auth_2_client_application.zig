/// The OAuth2Client application.
pub const OAuth2ClientApplication = struct {
    /// The Amazon Web Services managed client application reference in the
    /// OAuth2Client application.
    a_ws_managed_client_application_reference: ?[]const u8 = null,

    /// The user managed client application client ID in the OAuth2Client
    /// application.
    user_managed_client_application_client_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .a_ws_managed_client_application_reference = "aWSManagedClientApplicationReference",
        .user_managed_client_application_client_id = "userManagedClientApplicationClientId",
    };
};
