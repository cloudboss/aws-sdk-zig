pub const OAuthScopesElement = enum {
    phone,
    email,
    openid,
    profile,
    aws_cognito_signin_user_admin,

    pub const json_field_names = .{
        .phone = "PHONE",
        .email = "EMAIL",
        .openid = "OPENID",
        .profile = "PROFILE",
        .aws_cognito_signin_user_admin = "AWS_COGNITO_SIGNIN_USER_ADMIN",
    };
};
