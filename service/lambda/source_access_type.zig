pub const SourceAccessType = enum {
    basic_auth,
    vpc_subnet,
    vpc_security_group,
    sasl_scram_512_auth,
    sasl_scram_256_auth,
    virtual_host,
    client_certificate_tls_auth,
    server_root_ca_certificate,

    pub const json_field_names = .{
        .basic_auth = "BASIC_AUTH",
        .vpc_subnet = "VPC_SUBNET",
        .vpc_security_group = "VPC_SECURITY_GROUP",
        .sasl_scram_512_auth = "SASL_SCRAM_512_AUTH",
        .sasl_scram_256_auth = "SASL_SCRAM_256_AUTH",
        .virtual_host = "VIRTUAL_HOST",
        .client_certificate_tls_auth = "CLIENT_CERTIFICATE_TLS_AUTH",
        .server_root_ca_certificate = "SERVER_ROOT_CA_CERTIFICATE",
    };
};
