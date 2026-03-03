const ClientCompatibilityV3 = @import("client_compatibility_v3.zig").ClientCompatibilityV3;

/// Private key flags for v3 templates specify the client compatibility, if the
/// private key
/// can be exported, if user input is required when using a private key, and if
/// an alternate
/// signature algorithm should be used.
pub const PrivateKeyFlagsV3 = struct {
    /// Defines the minimum client compatibility.
    client_version: ClientCompatibilityV3,

    /// Allows the private key to be exported.
    exportable_key: ?bool = null,

    /// Reguires the PKCS #1 v2.1 signature format for certificates. You should
    /// verify that your
    /// CA, objects, and applications can accept this signature format.
    require_alternate_signature_algorithm: ?bool = null,

    /// Requirer user input when using the private key for enrollment.
    strong_key_protection_required: ?bool = null,

    pub const json_field_names = .{
        .client_version = "ClientVersion",
        .exportable_key = "ExportableKey",
        .require_alternate_signature_algorithm = "RequireAlternateSignatureAlgorithm",
        .strong_key_protection_required = "StrongKeyProtectionRequired",
    };
};
