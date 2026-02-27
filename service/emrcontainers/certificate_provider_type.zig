pub const CertificateProviderType = enum {
    pem,

    pub const json_field_names = .{
        .pem = "PEM",
    };
};
