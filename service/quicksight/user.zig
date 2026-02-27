const IdentityType = @import("identity_type.zig").IdentityType;
const UserRole = @import("user_role.zig").UserRole;

/// A registered user of Quick Sight.
pub const User = struct {
    /// The active status of user. When you create an Quick Sight user that's not an
    /// IAM user or an Active Directory user, that user is inactive until they sign
    /// in and provide a
    /// password.
    active: bool = false,

    /// The Amazon Resource Name (ARN) for the user.
    arn: ?[]const u8,

    /// The custom permissions profile associated with this user.
    custom_permissions_name: ?[]const u8,

    /// The user's email address.
    email: ?[]const u8,

    /// The type of supported external login provider that provides identity to let
    /// the user
    /// federate into Quick Sight with an associated IAM role. The type can be one
    /// of the following.
    ///
    /// * `COGNITO`: Amazon Cognito. The provider URL is
    ///   cognito-identity.amazonaws.com.
    ///
    /// * `CUSTOM_OIDC`: Custom OpenID Connect (OIDC) provider.
    external_login_federation_provider_type: ?[]const u8,

    /// The URL of the external login provider.
    external_login_federation_provider_url: ?[]const u8,

    /// The identity ID for the user in the external login provider.
    external_login_id: ?[]const u8,

    /// The type of identity authentication used by the user.
    identity_type: ?IdentityType,

    /// The principal ID of the user.
    principal_id: ?[]const u8,

    /// The Quick Sight role for the user. The user role can be one of the
    /// following:.
    ///
    /// * `READER`: A user who has read-only access to dashboards.
    ///
    /// * `AUTHOR`: A user who can create data sources, datasets, analyses,
    /// and dashboards.
    ///
    /// * `ADMIN`: A user who is an author, who can also manage Amazon
    /// Quick Sight settings.
    ///
    /// * `READER_PRO`: Reader Pro adds Generative BI capabilities to the Reader
    ///   role. Reader Pros have access to Amazon Q in Quick Sight, can build
    ///   stories with Amazon Q, and can generate executive summaries from
    ///   dashboards.
    ///
    /// * `AUTHOR_PRO`: Author Pro adds Generative BI capabilities to the Author
    ///   role. Author Pros can author dashboards with natural language with Amazon
    ///   Q, build stories with Amazon Q, create Topics for Q&A, and generate
    ///   executive summaries from dashboards.
    ///
    /// * `ADMIN_PRO`: Admin Pros are Author Pros who can also manage Quick Sight
    ///   administrative settings. Admin Pro users are billed at Author Pro pricing.
    ///
    /// * `RESTRICTED_READER`: This role isn't currently available for
    /// use.
    ///
    /// * `RESTRICTED_AUTHOR`: This role isn't currently available for
    /// use.
    role: ?UserRole,

    /// The user's user name. This value is required if you are registering a user
    /// that will be managed in Quick Sight. In the output, the value for `UserName`
    /// is
    /// `N/A` when the value for `IdentityType` is `IAM`
    /// and the corresponding IAM user is deleted.
    user_name: ?[]const u8,

    pub const json_field_names = .{
        .active = "Active",
        .arn = "Arn",
        .custom_permissions_name = "CustomPermissionsName",
        .email = "Email",
        .external_login_federation_provider_type = "ExternalLoginFederationProviderType",
        .external_login_federation_provider_url = "ExternalLoginFederationProviderUrl",
        .external_login_id = "ExternalLoginId",
        .identity_type = "IdentityType",
        .principal_id = "PrincipalId",
        .role = "Role",
        .user_name = "UserName",
    };
};
