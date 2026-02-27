pub const CertificateType = enum {
    client_cert_auth,
    client_ldaps,

    pub const json_field_names = .{
        .client_cert_auth = "CLIENT_CERT_AUTH",
        .client_ldaps = "CLIENT_LDAPS",
    };
};
