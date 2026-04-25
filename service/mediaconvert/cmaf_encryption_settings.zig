const HlsClearLead = @import("hls_clear_lead.zig").HlsClearLead;
const CmafEncryptionType = @import("cmaf_encryption_type.zig").CmafEncryptionType;
const CmafInitializationVectorInManifest = @import("cmaf_initialization_vector_in_manifest.zig").CmafInitializationVectorInManifest;
const SpekeKeyProviderCmaf = @import("speke_key_provider_cmaf.zig").SpekeKeyProviderCmaf;
const StaticKeyProvider = @import("static_key_provider.zig").StaticKeyProvider;
const CmafKeyProviderType = @import("cmaf_key_provider_type.zig").CmafKeyProviderType;

/// Settings for CMAF encryption
pub const CmafEncryptionSettings = struct {
    /// Enable Clear Lead DRM to reduce video startup latency by leaving the first
    /// segment unencrypted while DRM license retrieval occurs in parallel. This
    /// optimization allows immediate playback startup while maintaining content
    /// protection for the remainder of the stream. When enabled, the first output
    /// segment remains fully unencrypted, and encryption begins at the start of the
    /// second segment. The HLS manifest will omit #EXT-X-KEY tags during the clear
    /// segment and insert the first #EXT-X-KEY immediately before the first
    /// encrypted fragment. This feature is supported exclusively for CMAF HLS
    /// (fMP4) outputs and is compatible with all existing key provider integrations
    /// (SPEKE v1, SPEKE v2, and Static Key encryption). Supported codecs: H.264,
    /// H.265, and AV1 video codecs, and AAC audio codec. Choose Enabled to activate
    /// Clear Lead DRM optimization. Choose Disabled to use standard encryption
    /// where all segments are encrypted from the beginning.
    clear_lead: ?HlsClearLead = null,

    /// This is a 128-bit, 16-byte hex value represented by a 32-character text
    /// string. If this parameter is not set then the Initialization Vector will
    /// follow the segment number by default.
    constant_initialization_vector: ?[]const u8 = null,

    /// Specify the encryption scheme that you want the service to use when
    /// encrypting your CMAF segments. Choose AES-CBC subsample or AES_CTR.
    encryption_method: ?CmafEncryptionType = null,

    /// When you use DRM with CMAF outputs, choose whether the service writes the
    /// 128-bit encryption initialization vector in the HLS and DASH manifests.
    initialization_vector_in_manifest: ?CmafInitializationVectorInManifest = null,

    /// If your output group type is CMAF, use these settings when doing DRM
    /// encryption with a SPEKE-compliant key provider. If your output group type is
    /// HLS, DASH, or Microsoft Smooth, use the SpekeKeyProvider settings instead.
    speke_key_provider: ?SpekeKeyProviderCmaf = null,

    /// Use these settings to set up encryption with a static key provider.
    static_key_provider: ?StaticKeyProvider = null,

    /// Specify whether your DRM encryption key is static or from a key provider
    /// that follows the SPEKE standard. For more information about SPEKE, see
    /// https://docs.aws.amazon.com/speke/latest/documentation/what-is-speke.html.
    @"type": ?CmafKeyProviderType = null,

    pub const json_field_names = .{
        .clear_lead = "ClearLead",
        .constant_initialization_vector = "ConstantInitializationVector",
        .encryption_method = "EncryptionMethod",
        .initialization_vector_in_manifest = "InitializationVectorInManifest",
        .speke_key_provider = "SpekeKeyProvider",
        .static_key_provider = "StaticKeyProvider",
        .@"type" = "Type",
    };
};
