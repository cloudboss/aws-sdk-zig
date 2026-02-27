const ClientCredentialsGrantDetails = @import("client_credentials_grant_details.zig").ClientCredentialsGrantDetails;

/// Details for OAuth 2.0 client credentials grant authentication.
pub const ClientCredentialsDetails = union(enum) {
    /// The OAuth2 client credentials grant configuration details for
    /// authentication.
    client_credentials_grant_details: ?ClientCredentialsGrantDetails,

    pub const json_field_names = .{
        .client_credentials_grant_details = "ClientCredentialsGrantDetails",
    };
};
