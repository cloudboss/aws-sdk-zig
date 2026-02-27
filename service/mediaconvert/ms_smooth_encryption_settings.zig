const SpekeKeyProvider = @import("speke_key_provider.zig").SpekeKeyProvider;

/// If you are using DRM, set DRM System to specify the value SpekeKeyProvider.
pub const MsSmoothEncryptionSettings = struct {
    /// If your output group type is HLS, DASH, or Microsoft Smooth, use these
    /// settings when doing DRM encryption with a SPEKE-compliant key provider. If
    /// your output group type is CMAF, use the SpekeKeyProviderCmaf settings
    /// instead.
    speke_key_provider: ?SpekeKeyProvider,

    pub const json_field_names = .{
        .speke_key_provider = "SpekeKeyProvider",
    };
};
