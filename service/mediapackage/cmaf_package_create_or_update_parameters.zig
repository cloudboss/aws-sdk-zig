const CmafEncryption = @import("cmaf_encryption.zig").CmafEncryption;
const HlsManifestCreateOrUpdateParameters = @import("hls_manifest_create_or_update_parameters.zig").HlsManifestCreateOrUpdateParameters;
const StreamSelection = @import("stream_selection.zig").StreamSelection;

/// A Common Media Application Format (CMAF) packaging configuration.
pub const CmafPackageCreateOrUpdateParameters = struct {
    encryption: ?CmafEncryption = null,

    /// A list of HLS manifest configurations
    hls_manifests: ?[]const HlsManifestCreateOrUpdateParameters = null,

    /// Duration (in seconds) of each segment. Actual segments will be
    /// rounded to the nearest multiple of the source segment duration.
    segment_duration_seconds: ?i32 = null,

    /// An optional custom string that is prepended to the name of each segment. If
    /// not specified, it defaults to the ChannelId.
    segment_prefix: ?[]const u8 = null,

    stream_selection: ?StreamSelection = null,

    pub const json_field_names = .{
        .encryption = "Encryption",
        .hls_manifests = "HlsManifests",
        .segment_duration_seconds = "SegmentDurationSeconds",
        .segment_prefix = "SegmentPrefix",
        .stream_selection = "StreamSelection",
    };
};
