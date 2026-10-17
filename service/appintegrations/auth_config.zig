const AuthType = @import("auth_type.zig").AuthType;

/// Contains the authentication settings that Connect Customer uses to call an
/// external application endpoint.
pub const AuthConfig = struct {
    /// The value that Connect Customer uses as the audience (`aud`) claim of the
    /// JSON Web Token (JWT) that it issues. You can specify this parameter only
    /// when `AuthType` is `CONNECT_JWT`. If you don't specify it, the audience is
    /// the `AccessUrl` of the application. The value can't contain
    /// `connect.amazonaws.com`.
    audience_override: ?[]const u8 = null,

    /// The type of authentication that Connect Customer uses to call the external
    /// application endpoint. You must specify an authentication type for
    /// `A2A_SERVER` applications. Valid values:
    ///
    /// * `API_KEY`: Connect Customer sends an API key that is stored in the Secrets
    ///   Manager secret that you specify in `CredentialProviderIdentifier`.
    ///
    /// * `CONNECT_JWT`: Connect Customer issues a short-lived, signed JSON Web
    ///   Token (JWT). This authentication type doesn't require a stored credential.
    auth_type: ?AuthType = null,

    /// The ARN of the Secrets Manager secret that stores the credentials. The
    /// secret must be accessible to Connect Customer.
    ///
    /// You must specify this ARN when `AuthType` is `API_KEY`. Don't specify it
    /// when `AuthType` is `CONNECT_JWT`.
    credential_provider_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .audience_override = "AudienceOverride",
        .auth_type = "AuthType",
        .credential_provider_identifier = "CredentialProviderIdentifier",
    };
};
