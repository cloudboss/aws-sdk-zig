/// The Secrets Manager secret that stores your stream credentials.
pub const SelfManagedKafkaAccessConfigurationCredentials = union(enum) {
    /// The ARN of the Secrets Manager secret.
    basic_auth: ?[]const u8,
    /// The ARN of the Secrets Manager secret.
    client_certificate_tls_auth: ?[]const u8,
    /// The ARN of the Secrets Manager secret.
    sasl_scram_256_auth: ?[]const u8,
    /// The ARN of the Secrets Manager secret.
    sasl_scram_512_auth: ?[]const u8,

    pub const json_field_names = .{
        .basic_auth = "BasicAuth",
        .client_certificate_tls_auth = "ClientCertificateTlsAuth",
        .sasl_scram_256_auth = "SaslScram256Auth",
        .sasl_scram_512_auth = "SaslScram512Auth",
    };
};
