const ClientCompatibilityV4 = @import("client_compatibility_v4.zig").ClientCompatibilityV4;

/// Private key flags for v4 templates specify the client compatibility, if the
/// private key
/// can be exported, if user input is required when using a private key, if an
/// alternate
/// signature algorithm should be used, and if certificates are renewed using
/// the same private
/// key.
pub const PrivateKeyFlagsV4 = struct {
    /// Defines the minimum client compatibility.
    client_version: ClientCompatibilityV4,

    /// Allows the private key to be exported.
    exportable_key: ?bool = null,

    /// Requires the PKCS #1 v2.1 signature format for certificates. You should
    /// verify that your
    /// CA, objects, and applications can accept this signature format.
    require_alternate_signature_algorithm: ?bool = null,

    /// Renew certificate using the same private key.
    require_same_key_renewal: ?bool = null,

    /// Require user input when using the private key for enrollment.
    strong_key_protection_required: ?bool = null,

    /// Specifies the cryptographic service provider category used to generate
    /// private keys. Set
    /// to TRUE to use Legacy Cryptographic Service Providers and FALSE to use Key
    /// Storage
    /// Providers.
    use_legacy_provider: ?bool = null,

    pub const json_field_names = .{
        .client_version = "ClientVersion",
        .exportable_key = "ExportableKey",
        .require_alternate_signature_algorithm = "RequireAlternateSignatureAlgorithm",
        .require_same_key_renewal = "RequireSameKeyRenewal",
        .strong_key_protection_required = "StrongKeyProtectionRequired",
        .use_legacy_provider = "UseLegacyProvider",
    };
};
