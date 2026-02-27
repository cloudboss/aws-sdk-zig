const AuthorizationCodeGrantCredentialsDetails = @import("authorization_code_grant_credentials_details.zig").AuthorizationCodeGrantCredentialsDetails;
const AuthorizationCodeGrantCredentialsSource = @import("authorization_code_grant_credentials_source.zig").AuthorizationCodeGrantCredentialsSource;

/// Metadata for OAuth 2.0 authorization code grant authentication.
pub const AuthorizationCodeGrantMetadata = struct {
    /// The detailed credentials configuration for authorization code grant.
    authorization_code_grant_credentials_details: ?AuthorizationCodeGrantCredentialsDetails,

    /// The source of the authorization code grant credentials.
    authorization_code_grant_credentials_source: ?AuthorizationCodeGrantCredentialsSource,

    /// The base URL endpoint for the external service.
    base_endpoint: []const u8,

    /// The redirect URL for the OAuth authorization flow.
    redirect_url: []const u8,

    pub const json_field_names = .{
        .authorization_code_grant_credentials_details = "AuthorizationCodeGrantCredentialsDetails",
        .authorization_code_grant_credentials_source = "AuthorizationCodeGrantCredentialsSource",
        .base_endpoint = "BaseEndpoint",
        .redirect_url = "RedirectUrl",
    };
};
