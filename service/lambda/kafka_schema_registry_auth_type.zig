pub const KafkaSchemaRegistryAuthType = enum {
    basic_auth,
    client_certificate_tls_auth,
    server_root_ca_certificate,

    pub const json_field_names = .{
        .basic_auth = "BASIC_AUTH",
        .client_certificate_tls_auth = "CLIENT_CERTIFICATE_TLS_AUTH",
        .server_root_ca_certificate = "SERVER_ROOT_CA_CERTIFICATE",
    };
};
