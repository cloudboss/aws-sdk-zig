const PublicTlsEncryptionConfiguration = @import("public_tls_encryption_configuration.zig").PublicTlsEncryptionConfiguration;

/// The configuration settings for TLS encryption.
pub const TlsEncryptionConfiguration = union(enum) {
    /// The TLS encryption configuration that validates the destination by using a
    /// publicly trusted certificate authority.
    public: ?PublicTlsEncryptionConfiguration,

    pub const json_field_names = .{
        .public = "Public",
    };
};
