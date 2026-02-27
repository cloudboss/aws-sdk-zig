pub const SslSecurityProtocolValue = enum {
    plaintext,
    ssl_encryption,

    pub const json_field_names = .{
        .plaintext = "PLAINTEXT",
        .ssl_encryption = "SSL_ENCRYPTION",
    };
};
