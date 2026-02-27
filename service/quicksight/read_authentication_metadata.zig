const ReadAPIKeyConnectionMetadata = @import("read_api_key_connection_metadata.zig").ReadAPIKeyConnectionMetadata;
const ReadAuthorizationCodeGrantMetadata = @import("read_authorization_code_grant_metadata.zig").ReadAuthorizationCodeGrantMetadata;
const ReadBasicAuthConnectionMetadata = @import("read_basic_auth_connection_metadata.zig").ReadBasicAuthConnectionMetadata;
const ReadClientCredentialsGrantMetadata = @import("read_client_credentials_grant_metadata.zig").ReadClientCredentialsGrantMetadata;
const ReadIamConnectionMetadata = @import("read_iam_connection_metadata.zig").ReadIamConnectionMetadata;
const ReadNoneConnectionMetadata = @import("read_none_connection_metadata.zig").ReadNoneConnectionMetadata;

/// Read-only authentication metadata union containing non-sensitive
/// configuration details for different authentication types.
pub const ReadAuthenticationMetadata = union(enum) {
    /// Read-only metadata for API key authentication configuration.
    api_key_connection_metadata: ?ReadAPIKeyConnectionMetadata,
    /// Read-only metadata for OAuth2 authorization code grant flow configuration.
    authorization_code_grant_metadata: ?ReadAuthorizationCodeGrantMetadata,
    /// Read-only metadata for basic authentication configuration.
    basic_auth_connection_metadata: ?ReadBasicAuthConnectionMetadata,
    /// Read-only metadata for OAuth2 client credentials grant flow configuration.
    client_credentials_grant_metadata: ?ReadClientCredentialsGrantMetadata,
    /// Read-only metadata for IAM-based authentication configuration.
    iam_connection_metadata: ?ReadIamConnectionMetadata,
    /// Read-only metadata for connections that do not require authentication.
    none_connection_metadata: ?ReadNoneConnectionMetadata,

    pub const json_field_names = .{
        .api_key_connection_metadata = "ApiKeyConnectionMetadata",
        .authorization_code_grant_metadata = "AuthorizationCodeGrantMetadata",
        .basic_auth_connection_metadata = "BasicAuthConnectionMetadata",
        .client_credentials_grant_metadata = "ClientCredentialsGrantMetadata",
        .iam_connection_metadata = "IamConnectionMetadata",
        .none_connection_metadata = "NoneConnectionMetadata",
    };
};
