/// Options to specify the Cognito user and identity pools for Kibana
/// authentication. For more information, see [Amazon Cognito Authentication for
/// Kibana](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-cognito-auth.html).
pub const CognitoOptions = struct {
    /// Specifies the option to enable Cognito for Kibana authentication.
    enabled: ?bool = null,

    /// Specifies the Cognito identity pool ID for Kibana authentication.
    identity_pool_id: ?[]const u8 = null,

    /// Specifies the role ARN that provides Elasticsearch permissions for accessing
    /// Cognito resources.
    role_arn: ?[]const u8 = null,

    /// Specifies the Cognito user pool ID for Kibana authentication.
    user_pool_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .identity_pool_id = "IdentityPoolId",
        .role_arn = "RoleArn",
        .user_pool_id = "UserPoolId",
    };
};
