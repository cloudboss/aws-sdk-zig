pub const SourceAccessType = enum {
    basic_auth,
    vpc_subnet,
    vpc_security_group,
    sasl_scram_512_auth,
    sasl_scram_256_auth,
    virtual_host,
    client_certificate_tls_auth,
    server_root_ca_certificate,
};
