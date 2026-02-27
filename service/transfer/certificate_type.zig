pub const CertificateType = enum {
    certificate,
    certificate_with_private_key,

    pub const json_field_names = .{
        .certificate = "CERTIFICATE",
        .certificate_with_private_key = "CERTIFICATE_WITH_PRIVATE_KEY",
    };
};
