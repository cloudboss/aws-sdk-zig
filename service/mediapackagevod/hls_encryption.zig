const EncryptionMethod = @import("encryption_method.zig").EncryptionMethod;
const SpekeKeyProvider = @import("speke_key_provider.zig").SpekeKeyProvider;

/// An HTTP Live Streaming (HLS) encryption configuration.
pub const HlsEncryption = struct {
    /// A constant initialization vector for encryption (optional).
    /// When not specified the initialization vector will be periodically rotated.
    constant_initialization_vector: ?[]const u8,

    /// The encryption method to use.
    encryption_method: ?EncryptionMethod,

    speke_key_provider: SpekeKeyProvider,

    pub const json_field_names = .{
        .constant_initialization_vector = "ConstantInitializationVector",
        .encryption_method = "EncryptionMethod",
        .speke_key_provider = "SpekeKeyProvider",
    };
};
