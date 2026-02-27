pub const CertificateField = enum {
    x_509_subject,
    x_509_issuer,
    x_509_san,

    pub const json_field_names = .{
        .x_509_subject = "x509Subject",
        .x_509_issuer = "x509Issuer",
        .x_509_san = "x509SAN",
    };
};
