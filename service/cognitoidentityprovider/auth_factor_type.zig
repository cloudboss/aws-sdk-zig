pub const AuthFactorType = enum {
    password,
    email_otp,
    sms_otp,
    web_authn,

    pub const json_field_names = .{
        .password = "PASSWORD",
        .email_otp = "EMAIL_OTP",
        .sms_otp = "SMS_OTP",
        .web_authn = "WEB_AUTHN",
    };
};
