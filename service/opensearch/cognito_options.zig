/// Container for the parameters required to enable Cognito authentication for
/// an
/// OpenSearch Service domain. For more information, see [Configuring Amazon
/// Cognito authentication for OpenSearch
/// Dashboards](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/cognito-auth.html).
pub const CognitoOptions = struct {
    /// Whether to enable or disable Amazon Cognito authentication for OpenSearch
    /// Dashboards.
    enabled: ?bool,

    /// The Amazon Cognito identity pool ID that you want OpenSearch Service to use
    /// for
    /// OpenSearch Dashboards authentication.
    identity_pool_id: ?[]const u8,

    /// The `AmazonOpenSearchServiceCognitoAccess` role that allows OpenSearch
    /// Service to configure your user pool and identity pool.
    role_arn: ?[]const u8,

    /// The Amazon Cognito user pool ID that you want OpenSearch Service to use for
    /// OpenSearch
    /// Dashboards authentication.
    user_pool_id: ?[]const u8,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .identity_pool_id = "IdentityPoolId",
        .role_arn = "RoleArn",
        .user_pool_id = "UserPoolId",
    };
};
