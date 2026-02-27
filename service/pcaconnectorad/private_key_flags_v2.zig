const ClientCompatibilityV2 = @import("client_compatibility_v2.zig").ClientCompatibilityV2;

/// Private key flags for v2 templates specify the client compatibility, if the
/// private key
/// can be exported, and if user input is required when using a private key.
pub const PrivateKeyFlagsV2 = struct {
    /// Defines the minimum client compatibility.
    client_version: ClientCompatibilityV2,

    /// Allows the private key to be exported.
    exportable_key: ?bool,

    /// Require user input when using the private key for enrollment.
    strong_key_protection_required: ?bool,

    pub const json_field_names = .{
        .client_version = "ClientVersion",
        .exportable_key = "ExportableKey",
        .strong_key_protection_required = "StrongKeyProtectionRequired",
    };
};
