/// Specifies the authorization configuration for using Amazon Cognito user
/// pools with your AppSync GraphQL API
/// endpoint.
pub const AwsAppSyncGraphQlApiUserPoolConfigDetails = struct {
    /// A regular expression for validating the incoming Amazon Cognito user pools
    /// app client ID. If this value isn't set, no
    /// filtering is applied.
    app_id_client_regex: ?[]const u8 = null,

    /// The Amazon Web Services Region in which the user pool was created.
    aws_region: ?[]const u8 = null,

    /// The action that you want your GraphQL API to take when a request that uses
    /// Amazon Cognito user pools
    /// authentication doesn't match the Amazon Cognito user pools configuration.
    default_action: ?[]const u8 = null,

    /// The user pool ID.
    user_pool_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_id_client_regex = "AppIdClientRegex",
        .aws_region = "AwsRegion",
        .default_action = "DefaultAction",
        .user_pool_id = "UserPoolId",
    };
};
