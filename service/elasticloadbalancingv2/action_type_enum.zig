pub const ActionTypeEnum = enum {
    forward,
    authenticate_oidc,
    authenticate_cognito,
    redirect,
    fixed_response,
    jwt_validation,
};
