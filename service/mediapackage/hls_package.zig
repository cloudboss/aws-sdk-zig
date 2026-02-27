const AdMarkers = @import("ad_markers.zig").AdMarkers;
const AdsOnDeliveryRestrictions = @import("ads_on_delivery_restrictions.zig").AdsOnDeliveryRestrictions;
const __AdTriggersElement = @import("ad_triggers_element.zig").__AdTriggersElement;
const HlsEncryption = @import("hls_encryption.zig").HlsEncryption;
const PlaylistType = @import("playlist_type.zig").PlaylistType;
const StreamSelection = @import("stream_selection.zig").StreamSelection;

/// An HTTP Live Streaming (HLS) packaging configuration.
pub const HlsPackage = struct {
    /// This setting controls how ad markers are included in the packaged
    /// OriginEndpoint.
    /// "NONE" will omit all SCTE-35 ad markers from the output.
    /// "PASSTHROUGH" causes the manifest to contain a copy of the SCTE-35 ad
    /// markers (comments) taken directly from the input HTTP Live Streaming (HLS)
    /// manifest.
    /// "SCTE35_ENHANCED" generates ad markers and blackout tags based on SCTE-35
    /// messages in the input source.
    /// "DATERANGE" inserts EXT-X-DATERANGE tags to signal ad and program transition
    /// events
    /// in HLS and CMAF manifests. For this option, you must set a
    /// programDateTimeIntervalSeconds value
    /// that is greater than 0.
    ad_markers: ?AdMarkers,

    ads_on_delivery_restrictions: ?AdsOnDeliveryRestrictions,

    ad_triggers: ?[]const __AdTriggersElement,

    encryption: ?HlsEncryption,

    /// When enabled, MediaPackage passes through digital video broadcasting (DVB)
    /// subtitles into the output.
    include_dvb_subtitles: ?bool,

    /// When enabled, an I-Frame only stream will be included in the output.
    include_iframe_only_stream: ?bool,

    /// The HTTP Live Streaming (HLS) playlist type.
    /// When either "EVENT" or "VOD" is specified, a corresponding
    /// EXT-X-PLAYLIST-TYPE
    /// entry will be included in the media playlist.
    playlist_type: ?PlaylistType,

    /// Time window (in seconds) contained in each parent manifest.
    playlist_window_seconds: ?i32,

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
    program_date_time_interval_seconds: ?i32,

    /// Duration (in seconds) of each fragment. Actual fragments will be
    /// rounded to the nearest multiple of the source fragment duration.
    segment_duration_seconds: ?i32,

    stream_selection: ?StreamSelection,

    /// When enabled, audio streams will be placed in rendition groups in the
    /// output.
    use_audio_rendition_group: ?bool,

    pub const json_field_names = .{
        .ad_markers = "AdMarkers",
        .ads_on_delivery_restrictions = "AdsOnDeliveryRestrictions",
        .ad_triggers = "AdTriggers",
        .encryption = "Encryption",
        .include_dvb_subtitles = "IncludeDvbSubtitles",
        .include_iframe_only_stream = "IncludeIframeOnlyStream",
        .playlist_type = "PlaylistType",
        .playlist_window_seconds = "PlaylistWindowSeconds",
        .program_date_time_interval_seconds = "ProgramDateTimeIntervalSeconds",
        .segment_duration_seconds = "SegmentDurationSeconds",
        .stream_selection = "StreamSelection",
        .use_audio_rendition_group = "UseAudioRenditionGroup",
    };
};
