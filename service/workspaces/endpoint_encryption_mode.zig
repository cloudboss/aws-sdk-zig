pub const EndpointEncryptionMode = enum {
    standard_tls,
    fips_validated,

    pub const json_field_names = .{
        .standard_tls = "STANDARD_TLS",
        .fips_validated = "FIPS_VALIDATED",
    };
};
