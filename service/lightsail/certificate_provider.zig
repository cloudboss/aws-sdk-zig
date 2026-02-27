pub const CertificateProvider = enum {
    lets_encrypt,

    pub const json_field_names = .{
        .lets_encrypt = "LetsEncrypt",
    };
};
