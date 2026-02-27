const HlsEncryption = @import("hls_encryption.zig").HlsEncryption;
const HlsManifest = @import("hls_manifest.zig").HlsManifest;

/// An HTTP Live Streaming (HLS) packaging configuration.
pub const HlsPackage = struct {
    encryption: ?HlsEncryption,

    /// A list of HLS manifest configurations.
    hls_manifests: []const HlsManifest,

    /// When enabled, MediaPackage passes through digital video broadcasting (DVB)
    /// subtitles into the output.
    include_dvb_subtitles: ?bool,

    /// Duration (in seconds) of each fragment. Actual fragments will be
    /// rounded to the nearest multiple of the source fragment duration.
    segment_duration_seconds: ?i32,

    /// When enabled, audio streams will be placed in rendition groups in the
    /// output.
    use_audio_rendition_group: ?bool,

    pub const json_field_names = .{
        .encryption = "Encryption",
        .hls_manifests = "HlsManifests",
        .include_dvb_subtitles = "IncludeDvbSubtitles",
        .segment_duration_seconds = "SegmentDurationSeconds",
        .use_audio_rendition_group = "UseAudioRenditionGroup",
    };
};
