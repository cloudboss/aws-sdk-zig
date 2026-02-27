pub const AuthFlowType = enum {
    user_srp_auth,
    refresh_token_auth,
    refresh_token,
    custom_auth,
    admin_no_srp_auth,
    user_password_auth,
    admin_user_password_auth,
    user_auth,

    pub const json_field_names = .{
        .user_srp_auth = "USER_SRP_AUTH",
        .refresh_token_auth = "REFRESH_TOKEN_AUTH",
        .refresh_token = "REFRESH_TOKEN",
        .custom_auth = "CUSTOM_AUTH",
        .admin_no_srp_auth = "ADMIN_NO_SRP_AUTH",
        .user_password_auth = "USER_PASSWORD_AUTH",
        .admin_user_password_auth = "ADMIN_USER_PASSWORD_AUTH",
        .user_auth = "USER_AUTH",
    };
};
