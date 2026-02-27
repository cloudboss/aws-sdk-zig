pub const IngressTlsAttribute = enum {
    tls_protocol,

    pub const json_field_names = .{
        .tls_protocol = "TLS_PROTOCOL",
    };
};
