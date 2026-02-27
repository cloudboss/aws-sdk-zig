pub const AuthenticationType = enum {
    password,
    token,
    x509,

    pub const json_field_names = .{
        .password = "PASSWORD",
        .token = "TOKEN",
        .x509 = "X509",
    };
};
