const KeySpec = @import("key_spec.zig").KeySpec;

/// Defines the attributes of the private key.
pub const PrivateKeyAttributesV2 = struct {
    /// Defines the cryptographic providers used to generate the private key.
    crypto_providers: ?[]const []const u8,

    /// Defines the purpose of the private key. Set it to "KEY_EXCHANGE" or
    /// "SIGNATURE"
    /// value.
    key_spec: KeySpec,

    /// Set the minimum key length of the private key.
    minimal_key_length: i32,

    pub const json_field_names = .{
        .crypto_providers = "CryptoProviders",
        .key_spec = "KeySpec",
        .minimal_key_length = "MinimalKeyLength",
    };
};
