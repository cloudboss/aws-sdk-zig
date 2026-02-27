pub const ChallengeName = enum {
    password,
    mfa,

    pub const json_field_names = .{
        .password = "Password",
        .mfa = "Mfa",
    };
};
