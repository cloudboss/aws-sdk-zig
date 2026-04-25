/// The OAuth 2.0 client credentials used for authenticating a data source
/// connection.
/// Use this structure to provide a client ID, client secret, and username
/// directly
/// instead of referencing a secret stored in Amazon Secrets Manager. This
/// structure
/// supports data sources that use two-legged OAuth (2LO) authentication, such
/// as
/// Snowflake.
pub const OAuthClientCredentials = struct {
    /// The client ID of the OAuth 2.0 application that is registered with the data
    /// source
    /// provider.
    client_id: ?[]const u8 = null,

    /// The client secret of the OAuth 2.0 application that is registered with the
    /// data source
    /// provider.
    client_secret: ?[]const u8 = null,

    /// The username of the account that is used for OAuth 2.0 client credentials
    /// authentication with the data source provider.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_id = "ClientId",
        .client_secret = "ClientSecret",
        .username = "Username",
    };
};
