pub const CertificateProviderOperation = enum {
    create_certificate_from_csr,

    pub const json_field_names = .{
        .create_certificate_from_csr = "CreateCertificateFromCsr",
    };
};
