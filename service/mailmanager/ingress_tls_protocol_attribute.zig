pub const IngressTlsProtocolAttribute = enum {
    tls1_2,
    tls1_3,

    pub const json_field_names = .{
        .tls1_2 = "TLS1_2",
        .tls1_3 = "TLS1_3",
    };
};
