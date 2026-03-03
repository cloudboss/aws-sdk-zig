const AuthorizationCodeGrantCredentialsSource = @import("authorization_code_grant_credentials_source.zig").AuthorizationCodeGrantCredentialsSource;
const ReadAuthorizationCodeGrantCredentialsDetails = @import("read_authorization_code_grant_credentials_details.zig").ReadAuthorizationCodeGrantCredentialsDetails;

/// Read-only metadata for OAuth2 authorization code grant authentication
/// configuration.
pub const ReadAuthorizationCodeGrantMetadata = struct {
    /// The source of credentials for the authorization code grant flow.
    authorization_code_grant_credentials_source: ?AuthorizationCodeGrantCredentialsSource = null,

    /// The base endpoint URL for the OAuth2 authorization code grant flow.
    base_endpoint: []const u8,

    /// The read-only credentials details for the authorization code grant flow.
    read_authorization_code_grant_credentials_details: ?ReadAuthorizationCodeGrantCredentialsDetails = null,

    /// The redirect URL where the authorization server will send the user after
    /// authorization.
    redirect_url: []const u8,

    pub const json_field_names = .{
        .authorization_code_grant_credentials_source = "AuthorizationCodeGrantCredentialsSource",
        .base_endpoint = "BaseEndpoint",
        .read_authorization_code_grant_credentials_details = "ReadAuthorizationCodeGrantCredentialsDetails",
        .redirect_url = "RedirectUrl",
    };
};
