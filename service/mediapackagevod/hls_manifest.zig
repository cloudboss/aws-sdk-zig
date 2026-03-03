const AdMarkers = @import("ad_markers.zig").AdMarkers;
const StreamSelection = @import("stream_selection.zig").StreamSelection;

/// An HTTP Live Streaming (HLS) manifest configuration.
pub const HlsManifest = struct {
    /// This setting controls how ad markers are included in the packaged
    /// OriginEndpoint.
    /// "NONE" will omit all SCTE-35 ad markers from the output.
    /// "PASSTHROUGH" causes the manifest to contain a copy of the SCTE-35 ad
    /// markers (comments) taken directly from the input HTTP Live Streaming (HLS)
    /// manifest.
    /// "SCTE35_ENHANCED" generates ad markers and blackout tags based on SCTE-35
    /// messages in the input source.
    ad_markers: ?AdMarkers = null,

    /// When enabled, an I-Frame only stream will be included in the output.
    include_iframe_only_stream: ?bool = null,

    /// An optional string to include in the name of the manifest.
    manifest_name: ?[]const u8 = null,

    /// The interval (in seconds) between each EXT-X-PROGRAM-DATE-TIME tag
    /// inserted into manifests. Additionally, when an interval is specified
    /// ID3Timed Metadata messages will be generated every 5 seconds using the
    /// ingest time of the content.
    /// If the interval is not specified, or set to 0, then
    /// no EXT-X-PROGRAM-DATE-TIME tags will be inserted into manifests and no
    /// ID3Timed Metadata messages will be generated. Note that irrespective
    /// of this parameter, if any ID3 Timed Metadata is found in HTTP Live Streaming
    /// (HLS) input,
    /// it will be passed through to HLS output.
    program_date_time_interval_seconds: ?i32 = null,

    /// When enabled, the EXT-X-KEY tag will be repeated in output manifests.
    repeat_ext_x_key: ?bool = null,

    stream_selection: ?StreamSelection = null,

    pub const json_field_names = .{
        .ad_markers = "AdMarkers",
        .include_iframe_only_stream = "IncludeIframeOnlyStream",
        .manifest_name = "ManifestName",
        .program_date_time_interval_seconds = "ProgramDateTimeIntervalSeconds",
        .repeat_ext_x_key = "RepeatExtXKey",
        .stream_selection = "StreamSelection",
    };
};
