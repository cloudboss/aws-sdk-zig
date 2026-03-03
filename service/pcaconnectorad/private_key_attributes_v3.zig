const PrivateKeyAlgorithm = @import("private_key_algorithm.zig").PrivateKeyAlgorithm;
const KeySpec = @import("key_spec.zig").KeySpec;
const KeyUsageProperty = @import("key_usage_property.zig").KeyUsageProperty;

/// Defines the attributes of the private key.
pub const PrivateKeyAttributesV3 = struct {
    /// Defines the algorithm used to generate the private key.
    algorithm: PrivateKeyAlgorithm,

    /// Defines the cryptographic providers used to generate the private key.
    crypto_providers: ?[]const []const u8 = null,

    /// Defines the purpose of the private key. Set it to "KEY_EXCHANGE" or
    /// "SIGNATURE"
    /// value.
    key_spec: KeySpec,

    /// The key usage property defines the purpose of the private key contained in
    /// the
    /// certificate. You can specify specific purposes using property flags or all
    /// by using
    /// property type ALL.
    key_usage_property: KeyUsageProperty,

    /// Set the minimum key length of the private key.
    minimal_key_length: i32,

    pub const json_field_names = .{
        .algorithm = "Algorithm",
        .crypto_providers = "CryptoProviders",
        .key_spec = "KeySpec",
        .key_usage_property = "KeyUsageProperty",
        .minimal_key_length = "MinimalKeyLength",
    };
};
