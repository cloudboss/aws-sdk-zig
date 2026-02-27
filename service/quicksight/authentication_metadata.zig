const APIKeyConnectionMetadata = @import("api_key_connection_metadata.zig").APIKeyConnectionMetadata;
const AuthorizationCodeGrantMetadata = @import("authorization_code_grant_metadata.zig").AuthorizationCodeGrantMetadata;
const BasicAuthConnectionMetadata = @import("basic_auth_connection_metadata.zig").BasicAuthConnectionMetadata;
const ClientCredentialsGrantMetadata = @import("client_credentials_grant_metadata.zig").ClientCredentialsGrantMetadata;
const IAMConnectionMetadata = @import("iam_connection_metadata.zig").IAMConnectionMetadata;
const NoneConnectionMetadata = @import("none_connection_metadata.zig").NoneConnectionMetadata;

/// Union type containing authentication metadata for different authentication
/// methods.
pub const AuthenticationMetadata = union(enum) {
    /// API key authentication metadata.
    api_key_connection_metadata: ?APIKeyConnectionMetadata,
    /// OAuth 2.0 authorization code grant authentication metadata.
    authorization_code_grant_metadata: ?AuthorizationCodeGrantMetadata,
    /// Basic authentication metadata using username and password.
    basic_auth_connection_metadata: ?BasicAuthConnectionMetadata,
    /// OAuth 2.0 client credentials grant authentication metadata.
    client_credentials_grant_metadata: ?ClientCredentialsGrantMetadata,
    /// IAM role-based authentication metadata for Amazon Web Services services.
    iam_connection_metadata: ?IAMConnectionMetadata,
    /// No authentication metadata for services that don't require authentication.
    none_connection_metadata: ?NoneConnectionMetadata,

    pub const json_field_names = .{
        .api_key_connection_metadata = "ApiKeyConnectionMetadata",
        .authorization_code_grant_metadata = "AuthorizationCodeGrantMetadata",
        .basic_auth_connection_metadata = "BasicAuthConnectionMetadata",
        .client_credentials_grant_metadata = "ClientCredentialsGrantMetadata",
        .iam_connection_metadata = "IamConnectionMetadata",
        .none_connection_metadata = "NoneConnectionMetadata",
    };
};
