pub const AuthType = enum {
    ntlm,
    ssh,
    cert,

    pub const json_field_names = .{
        .ntlm = "NTLM",
        .ssh = "SSH",
        .cert = "CERT",
    };
};
