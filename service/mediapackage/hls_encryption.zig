const EncryptionMethod = @import("encryption_method.zig").EncryptionMethod;
const SpekeKeyProvider = @import("speke_key_provider.zig").SpekeKeyProvider;

/// An HTTP Live Streaming (HLS) encryption configuration.
pub const HlsEncryption = struct {
    /// A constant initialization vector for encryption (optional).
    /// When not specified the initialization vector will be periodically rotated.
    constant_initialization_vector: ?[]const u8 = null,

    /// The encryption method to use.
    encryption_method: ?EncryptionMethod = null,

    /// Interval (in seconds) between each encryption key rotation.
    key_rotation_interval_seconds: ?i32 = null,

    /// When enabled, the EXT-X-KEY tag will be repeated in output manifests.
    repeat_ext_x_key: ?bool = null,

    speke_key_provider: SpekeKeyProvider,

    pub const json_field_names = .{
        .constant_initialization_vector = "ConstantInitializationVector",
        .encryption_method = "EncryptionMethod",
        .key_rotation_interval_seconds = "KeyRotationIntervalSeconds",
        .repeat_ext_x_key = "RepeatExtXKey",
        .speke_key_provider = "SpekeKeyProvider",
    };
};
