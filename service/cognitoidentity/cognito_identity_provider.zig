/// A provider representing an Amazon Cognito user pool and its client ID.
pub const CognitoIdentityProvider = struct {
    /// The client ID for the Amazon Cognito user pool.
    client_id: ?[]const u8 = null,

    /// The provider name for an Amazon Cognito user pool. For example,
    /// `cognito-idp.us-east-1.amazonaws.com/us-east-1_123456789`.
    provider_name: ?[]const u8 = null,

    /// TRUE if server-side token validation is enabled for the identity provider’s
    /// token.
    ///
    /// Once you set `ServerSideTokenCheck` to TRUE for an identity pool, that
    /// identity pool will check with the integrated user pools to make sure that
    /// the user has not
    /// been globally signed out or deleted before the identity pool provides an
    /// OIDC token or
    /// Amazon Web Services credentials for the user.
    ///
    /// If the user is signed out or deleted, the identity pool will return a 400
    /// Not
    /// Authorized error.
    server_side_token_check: ?bool = null,

    pub const json_field_names = .{
        .client_id = "ClientId",
        .provider_name = "ProviderName",
        .server_side_token_check = "ServerSideTokenCheck",
    };
};
