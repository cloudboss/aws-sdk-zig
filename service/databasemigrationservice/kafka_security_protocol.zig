pub const KafkaSecurityProtocol = enum {
    plaintext,
    ssl_authentication,
    ssl_encryption,
    sasl_ssl,

    pub const json_field_names = .{
        .plaintext = "PLAINTEXT",
        .ssl_authentication = "SSL_AUTHENTICATION",
        .ssl_encryption = "SSL_ENCRYPTION",
        .sasl_ssl = "SASL_SSL",
    };
};
