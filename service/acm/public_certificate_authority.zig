const PublicKeyAlgorithm = @import("public_key_algorithm.zig").PublicKeyAlgorithm;

/// Configuration for a public certificate authority.
pub const PublicCertificateAuthority = struct {
    /// The key algorithms allowed for certificates issued by this certificate
    /// authority.
    allowed_key_algorithms: ?[]const PublicKeyAlgorithm = null,

    pub const json_field_names = .{
        .allowed_key_algorithms = "AllowedKeyAlgorithms",
    };
};
