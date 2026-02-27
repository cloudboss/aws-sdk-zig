pub const EventFilterType = enum {
    sign_in,
    password_change,
    sign_up,

    pub const json_field_names = .{
        .sign_in = "SIGN_IN",
        .password_change = "PASSWORD_CHANGE",
        .sign_up = "SIGN_UP",
    };
};
