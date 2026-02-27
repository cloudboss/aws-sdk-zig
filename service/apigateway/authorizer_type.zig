/// The authorizer type. Valid values are `TOKEN` for a Lambda function using a
/// single authorization token submitted in a custom header, `REQUEST` for a
/// Lambda function using incoming request parameters, and `COGNITO_USER_POOLS`
/// for using an Amazon Cognito user pool.
pub const AuthorizerType = enum {
    token,
    request,
    cognito_user_pools,

    pub const json_field_names = .{
        .token = "TOKEN",
        .request = "REQUEST",
        .cognito_user_pools = "COGNITO_USER_POOLS",
    };
};
