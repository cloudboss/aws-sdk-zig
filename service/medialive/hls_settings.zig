const AudioOnlyHlsSettings = @import("audio_only_hls_settings.zig").AudioOnlyHlsSettings;
const Fmp4HlsSettings = @import("fmp_4_hls_settings.zig").Fmp4HlsSettings;
const FrameCaptureHlsSettings = @import("frame_capture_hls_settings.zig").FrameCaptureHlsSettings;
const StandardHlsSettings = @import("standard_hls_settings.zig").StandardHlsSettings;

/// Hls Settings
pub const HlsSettings = struct {
    audio_only_hls_settings: ?AudioOnlyHlsSettings = null,

    fmp_4_hls_settings: ?Fmp4HlsSettings = null,

    frame_capture_hls_settings: ?FrameCaptureHlsSettings = null,

    standard_hls_settings: ?StandardHlsSettings = null,

    pub const json_field_names = .{
        .audio_only_hls_settings = "AudioOnlyHlsSettings",
        .fmp_4_hls_settings = "Fmp4HlsSettings",
        .frame_capture_hls_settings = "FrameCaptureHlsSettings",
        .standard_hls_settings = "StandardHlsSettings",
    };
};
