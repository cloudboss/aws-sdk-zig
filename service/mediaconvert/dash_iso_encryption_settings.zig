const DashIsoPlaybackDeviceCompatibility = @import("dash_iso_playback_device_compatibility.zig").DashIsoPlaybackDeviceCompatibility;
const SpekeKeyProvider = @import("speke_key_provider.zig").SpekeKeyProvider;

/// Specifies DRM settings for DASH outputs.
pub const DashIsoEncryptionSettings = struct {
    /// This setting can improve the compatibility of your output with video players
    /// on obsolete devices. It applies only to DASH H.264 outputs with DRM
    /// encryption. Choose Unencrypted SEI only to correct problems with playback on
    /// older devices. Otherwise, keep the default setting CENC v1. If you choose
    /// Unencrypted SEI, for that output, the service will exclude the access unit
    /// delimiter and will leave the SEI NAL units unencrypted.
    playback_device_compatibility: ?DashIsoPlaybackDeviceCompatibility = null,

    /// If your output group type is HLS, DASH, or Microsoft Smooth, use these
    /// settings when doing DRM encryption with a SPEKE-compliant key provider. If
    /// your output group type is CMAF, use the SpekeKeyProviderCmaf settings
    /// instead.
    speke_key_provider: ?SpekeKeyProvider = null,

    pub const json_field_names = .{
        .playback_device_compatibility = "PlaybackDeviceCompatibility",
        .speke_key_provider = "SpekeKeyProvider",
    };
};
