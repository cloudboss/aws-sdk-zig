/// The Secrets Manager secret that stores your stream credentials.
pub const MSKAccessCredentials = union(enum) {
    /// The ARN of the Secrets Manager secret.
    client_certificate_tls_auth: ?[]const u8,
    /// The ARN of the Secrets Manager secret.
    sasl_scram_512_auth: ?[]const u8,

    pub const json_field_names = .{
        .client_certificate_tls_auth = "ClientCertificateTlsAuth",
        .sasl_scram_512_auth = "SaslScram512Auth",
    };
};
