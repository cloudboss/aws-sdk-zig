const ReadClientCredentialsGrantDetails = @import("read_client_credentials_grant_details.zig").ReadClientCredentialsGrantDetails;

/// Read-only details for OAuth2 client credentials, containing non-sensitive
/// configuration information.
pub const ReadClientCredentialsDetails = union(enum) {
    /// The read-only client credentials grant configuration details.
    read_client_credentials_grant_details: ?ReadClientCredentialsGrantDetails,

    pub const json_field_names = .{
        .read_client_credentials_grant_details = "ReadClientCredentialsGrantDetails",
    };
};
