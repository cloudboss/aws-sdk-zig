const CmafEncryption = @import("cmaf_encryption.zig").CmafEncryption;
const HlsManifest = @import("hls_manifest.zig").HlsManifest;

/// A CMAF packaging configuration.
pub const CmafPackage = struct {
    encryption: ?CmafEncryption,

    /// A list of HLS manifest configurations.
    hls_manifests: []const HlsManifest,

    /// When includeEncoderConfigurationInSegments is set to true, MediaPackage
    /// places your encoder's Sequence Parameter Set (SPS), Picture Parameter Set
    /// (PPS), and Video Parameter Set (VPS) metadata in every video segment instead
    /// of in the init fragment. This lets you use different SPS/PPS/VPS settings
    /// for your assets during content playback.
    include_encoder_configuration_in_segments: ?bool,

    /// Duration (in seconds) of each fragment. Actual fragments will be
    /// rounded to the nearest multiple of the source fragment duration.
    segment_duration_seconds: ?i32,

    pub const json_field_names = .{
        .encryption = "Encryption",
        .hls_manifests = "HlsManifests",
        .include_encoder_configuration_in_segments = "IncludeEncoderConfigurationInSegments",
        .segment_duration_seconds = "SegmentDurationSeconds",
    };
};
