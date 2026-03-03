const ClientCredentialsSource = @import("client_credentials_source.zig").ClientCredentialsSource;
const ReadClientCredentialsDetails = @import("read_client_credentials_details.zig").ReadClientCredentialsDetails;

/// Read-only metadata for OAuth2 client credentials grant authentication
/// configuration.
pub const ReadClientCredentialsGrantMetadata = struct {
    /// The base endpoint URL for the OAuth2 client credentials grant flow.
    base_endpoint: []const u8,

    /// The source of client credentials for the OAuth2 client credentials grant
    /// flow.
    client_credentials_source: ?ClientCredentialsSource = null,

    /// The read-only client credentials configuration details.
    read_client_credentials_details: ?ReadClientCredentialsDetails = null,

    pub const json_field_names = .{
        .base_endpoint = "BaseEndpoint",
        .client_credentials_source = "ClientCredentialsSource",
        .read_client_credentials_details = "ReadClientCredentialsDetails",
    };
};
