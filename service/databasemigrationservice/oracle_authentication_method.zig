pub const OracleAuthenticationMethod = enum {
    password,
    kerberos,

    pub const json_field_names = .{
        .password = "Password",
        .kerberos = "Kerberos",
    };
};
