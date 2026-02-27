pub const SmbAuthenticationType = enum {
    ntlm,
    kerberos,

    pub const json_field_names = .{
        .ntlm = "NTLM",
        .kerberos = "KERBEROS",
    };
};
