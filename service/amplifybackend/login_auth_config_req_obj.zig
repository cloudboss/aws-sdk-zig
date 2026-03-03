/// The request object for this operation.
pub const LoginAuthConfigReqObj = struct {
    /// The Amazon Cognito identity pool ID used for the Amplify Admin UI login
    /// authorization.
    aws_cognito_identity_pool_id: ?[]const u8 = null,

    /// The AWS Region for the Amplify Admin UI login.
    aws_cognito_region: ?[]const u8 = null,

    /// The Amazon Cognito user pool ID used for Amplify Admin UI login
    /// authentication.
    aws_user_pools_id: ?[]const u8 = null,

    /// The web client ID for the Amazon Cognito user pools.
    aws_user_pools_web_client_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_cognito_identity_pool_id = "AwsCognitoIdentityPoolId",
        .aws_cognito_region = "AwsCognitoRegion",
        .aws_user_pools_id = "AwsUserPoolsId",
        .aws_user_pools_web_client_id = "AwsUserPoolsWebClientId",
    };
};
