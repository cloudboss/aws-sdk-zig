const SecretsManagerLocation = @import("secrets_manager_location.zig").SecretsManagerLocation;

/// The location from which to retrieve a certificate.
pub const CertificateLocation = union(enum) {
    /// The Amazon Web Services Secrets Manager location of the certificate.
    secrets_manager: ?SecretsManagerLocation,

    pub const json_field_names = .{
        .secrets_manager = "secretsManager",
    };
};
