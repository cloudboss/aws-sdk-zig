/// The OAuth2 client app used for the connection.
pub const OAuth2ClientApplication = struct {
    /// The reference to the SaaS-side client app that is Amazon Web Services
    /// managed.
    aws_managed_client_application_reference: ?[]const u8,

    /// The client application clientID if the ClientAppType is `USER_MANAGED`.
    user_managed_client_application_client_id: ?[]const u8,

    pub const json_field_names = .{
        .aws_managed_client_application_reference = "AWSManagedClientApplicationReference",
        .user_managed_client_application_client_id = "UserManagedClientApplicationClientId",
    };
};
