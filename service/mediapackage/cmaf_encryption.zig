const CmafEncryptionMethod = @import("cmaf_encryption_method.zig").CmafEncryptionMethod;
const SpekeKeyProvider = @import("speke_key_provider.zig").SpekeKeyProvider;

/// A Common Media Application Format (CMAF) encryption configuration.
pub const CmafEncryption = struct {
    /// An optional 128-bit, 16-byte hex value represented by a 32-character string,
    /// used in conjunction with the key for encrypting blocks. If you don't specify
    /// a value, then MediaPackage creates the constant initialization vector (IV).
    constant_initialization_vector: ?[]const u8,

    encryption_method: ?CmafEncryptionMethod,

    /// Time (in seconds) between each encryption key rotation.
    key_rotation_interval_seconds: ?i32,

    speke_key_provider: SpekeKeyProvider,

    pub const json_field_names = .{
        .constant_initialization_vector = "ConstantInitializationVector",
        .encryption_method = "EncryptionMethod",
        .key_rotation_interval_seconds = "KeyRotationIntervalSeconds",
        .speke_key_provider = "SpekeKeyProvider",
    };
};
