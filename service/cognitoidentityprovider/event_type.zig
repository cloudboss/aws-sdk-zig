pub const EventType = enum {
    sign_in,
    sign_up,
    forgot_password,
    password_change,
    resend_code,

    pub const json_field_names = .{
        .sign_in = "SignIn",
        .sign_up = "SignUp",
        .forgot_password = "ForgotPassword",
        .password_change = "PasswordChange",
        .resend_code = "ResendCode",
    };
};
