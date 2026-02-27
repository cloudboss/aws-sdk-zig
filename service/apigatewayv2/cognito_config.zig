/// The configuration for using Amazon Cognito user pools to control access to
/// your portal.
pub const CognitoConfig = struct {
    /// The app client ID.
    app_client_id: []const u8,

    /// The user pool ARN.
    user_pool_arn: []const u8,

    /// The user pool domain.
    user_pool_domain: []const u8,

    pub const json_field_names = .{
        .app_client_id = "AppClientId",
        .user_pool_arn = "UserPoolArn",
        .user_pool_domain = "UserPoolDomain",
    };
};
