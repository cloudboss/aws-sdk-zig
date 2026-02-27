pub const IngressTlsProtocolOperator = enum {
    minimum_tls_version,
    is,

    pub const json_field_names = .{
        .minimum_tls_version = "MINIMUM_TLS_VERSION",
        .is = "IS",
    };
};
