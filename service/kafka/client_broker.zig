/// Client-broker encryption in transit setting.
pub const ClientBroker = enum {
    tls,
    tls_plaintext,
    plaintext,

    pub const json_field_names = .{
        .tls = "TLS",
        .tls_plaintext = "TLS_PLAINTEXT",
        .plaintext = "PLAINTEXT",
    };
};
