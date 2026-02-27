pub const CertificateMode = enum {
    default,
    sni_only,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .sni_only = "SNI_ONLY",
    };
};
