pub const SignInMethod = enum {
    email,
    email_and_phone_number,
    phone_number,
    username,

    pub const json_field_names = .{
        .email = "EMAIL",
        .email_and_phone_number = "EMAIL_AND_PHONE_NUMBER",
        .phone_number = "PHONE_NUMBER",
        .username = "USERNAME",
    };
};
