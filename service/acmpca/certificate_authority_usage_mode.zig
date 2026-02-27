pub const CertificateAuthorityUsageMode = enum {
    general_purpose,
    short_lived_certificate,

    pub const json_field_names = .{
        .general_purpose = "GENERAL_PURPOSE",
        .short_lived_certificate = "SHORT_LIVED_CERTIFICATE",
    };
};
