const HlsEncryptionType = @import("hls_encryption_type.zig").HlsEncryptionType;
const HlsInitializationVectorInManifest = @import("hls_initialization_vector_in_manifest.zig").HlsInitializationVectorInManifest;
const HlsOfflineEncrypted = @import("hls_offline_encrypted.zig").HlsOfflineEncrypted;
const SpekeKeyProvider = @import("speke_key_provider.zig").SpekeKeyProvider;
const StaticKeyProvider = @import("static_key_provider.zig").StaticKeyProvider;
const HlsKeyProviderType = @import("hls_key_provider_type.zig").HlsKeyProviderType;

/// Settings for HLS encryption
pub const HlsEncryptionSettings = struct {
    /// This is a 128-bit, 16-byte hex value represented by a 32-character text
    /// string. If this parameter is not set then the Initialization Vector will
    /// follow the segment number by default.
    constant_initialization_vector: ?[]const u8 = null,

    /// Encrypts the segments with the given encryption scheme. Leave blank to
    /// disable. Selecting 'Disabled' in the web interface also disables encryption.
    encryption_method: ?HlsEncryptionType = null,

    /// The Initialization Vector is a 128-bit number used in conjunction with the
    /// key for encrypting blocks. If set to INCLUDE, Initialization Vector is
    /// listed in the manifest. Otherwise Initialization Vector is not in the
    /// manifest.
    initialization_vector_in_manifest: ?HlsInitializationVectorInManifest = null,

    /// Enable this setting to insert the EXT-X-SESSION-KEY element into the master
    /// playlist. This allows for offline Apple HLS FairPlay content protection.
    offline_encrypted: ?HlsOfflineEncrypted = null,

    /// If your output group type is HLS, DASH, or Microsoft Smooth, use these
    /// settings when doing DRM encryption with a SPEKE-compliant key provider. If
    /// your output group type is CMAF, use the SpekeKeyProviderCmaf settings
    /// instead.
    speke_key_provider: ?SpekeKeyProvider = null,

    /// Use these settings to set up encryption with a static key provider.
    static_key_provider: ?StaticKeyProvider = null,

    /// Specify whether your DRM encryption key is static or from a key provider
    /// that follows the SPEKE standard. For more information about SPEKE, see
    /// https://docs.aws.amazon.com/speke/latest/documentation/what-is-speke.html.
    @"type": ?HlsKeyProviderType = null,

    pub const json_field_names = .{
        .constant_initialization_vector = "ConstantInitializationVector",
        .encryption_method = "EncryptionMethod",
        .initialization_vector_in_manifest = "InitializationVectorInManifest",
        .offline_encrypted = "OfflineEncrypted",
        .speke_key_provider = "SpekeKeyProvider",
        .static_key_provider = "StaticKeyProvider",
        .@"type" = "Type",
    };
};
