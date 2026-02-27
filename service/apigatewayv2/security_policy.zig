/// The Transport Layer Security (TLS) version of the security policy for this
/// domain name. The valid values are TLS_1_0 and TLS_1_2.
pub const SecurityPolicy = enum {
    tls_1_0,
    tls_1_2,

    pub const json_field_names = .{
        .tls_1_0 = "TLS_1_0",
        .tls_1_2 = "TLS_1_2",
    };
};
