const ClientCredentialsDetails = @import("client_credentials_details.zig").ClientCredentialsDetails;
const ClientCredentialsSource = @import("client_credentials_source.zig").ClientCredentialsSource;

/// Configuration for OAuth 2.0 client credentials grant authentication,
/// including client ID, client secret, token endpoint, and optional scopes.
pub const ClientCredentialsGrantMetadata = struct {
    /// The base endpoint URL for the external service.
    base_endpoint: []const u8,

    /// The detailed client credentials configuration including client ID, client
    /// secret, and token endpoint.
    client_credentials_details: ?ClientCredentialsDetails = null,

    /// The source of the client credentials configuration.
    client_credentials_source: ?ClientCredentialsSource = null,

    pub const json_field_names = .{
        .base_endpoint = "BaseEndpoint",
        .client_credentials_details = "ClientCredentialsDetails",
        .client_credentials_source = "ClientCredentialsSource",
    };
};
