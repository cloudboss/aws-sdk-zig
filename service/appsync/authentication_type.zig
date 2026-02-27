pub const AuthenticationType = enum {
    api_key,
    aws_iam,
    amazon_cognito_user_pools,
    openid_connect,
    aws_lambda,

    pub const json_field_names = .{
        .api_key = "API_KEY",
        .aws_iam = "AWS_IAM",
        .amazon_cognito_user_pools = "AMAZON_COGNITO_USER_POOLS",
        .openid_connect = "OPENID_CONNECT",
        .aws_lambda = "AWS_LAMBDA",
    };
};
