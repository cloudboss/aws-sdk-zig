/// Use this parameter to configure your Amazon Cognito workforce. A single
/// Cognito workforce is created using and corresponds to a single [ Amazon
/// Cognito user
/// pool](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools.html).
pub const CognitoConfig = struct {
    /// The client ID for your Amazon Cognito user pool.
    client_id: []const u8,

    /// A [ user
    /// pool](https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools.html) is a user directory in Amazon Cognito. With a user pool, your users can sign in to your web or mobile app through Amazon Cognito. Your users can also sign in through social identity providers like Google, Facebook, Amazon, or Apple, and through SAML identity providers.
    user_pool: []const u8,

    pub const json_field_names = .{
        .client_id = "ClientId",
        .user_pool = "UserPool",
    };
};
