pub const CertificateUsageType = enum {
    signing,
    encryption,
    tls,

    pub const json_field_names = .{
        .signing = "SIGNING",
        .encryption = "ENCRYPTION",
        .tls = "TLS",
    };
};
