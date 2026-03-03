const HlsAdMarkers = @import("hls_ad_markers.zig").HlsAdMarkers;
const CaptionLanguageMapping = @import("caption_language_mapping.zig").CaptionLanguageMapping;
const HlsCaptionLanguageSetting = @import("hls_caption_language_setting.zig").HlsCaptionLanguageSetting;
const HlsClientCache = @import("hls_client_cache.zig").HlsClientCache;
const HlsCodecSpecification = @import("hls_codec_specification.zig").HlsCodecSpecification;
const OutputLocationRef = @import("output_location_ref.zig").OutputLocationRef;
const HlsDirectoryStructure = @import("hls_directory_structure.zig").HlsDirectoryStructure;
const HlsDiscontinuityTags = @import("hls_discontinuity_tags.zig").HlsDiscontinuityTags;
const HlsEncryptionType = @import("hls_encryption_type.zig").HlsEncryptionType;
const HlsCdnSettings = @import("hls_cdn_settings.zig").HlsCdnSettings;
const HlsId3SegmentTaggingState = @import("hls_id_3_segment_tagging_state.zig").HlsId3SegmentTaggingState;
const IFrameOnlyPlaylistType = @import("i_frame_only_playlist_type.zig").IFrameOnlyPlaylistType;
const HlsIncompleteSegmentBehavior = @import("hls_incomplete_segment_behavior.zig").HlsIncompleteSegmentBehavior;
const InputLossActionForHlsOut = @import("input_loss_action_for_hls_out.zig").InputLossActionForHlsOut;
const HlsIvInManifest = @import("hls_iv_in_manifest.zig").HlsIvInManifest;
const HlsIvSource = @import("hls_iv_source.zig").HlsIvSource;
const KeyProviderSettings = @import("key_provider_settings.zig").KeyProviderSettings;
const HlsManifestCompression = @import("hls_manifest_compression.zig").HlsManifestCompression;
const HlsManifestDurationFormat = @import("hls_manifest_duration_format.zig").HlsManifestDurationFormat;
const HlsMode = @import("hls_mode.zig").HlsMode;
const HlsOutputSelection = @import("hls_output_selection.zig").HlsOutputSelection;
const HlsProgramDateTime = @import("hls_program_date_time.zig").HlsProgramDateTime;
const HlsProgramDateTimeClock = @import("hls_program_date_time_clock.zig").HlsProgramDateTimeClock;
const HlsRedundantManifest = @import("hls_redundant_manifest.zig").HlsRedundantManifest;
const HlsSegmentationMode = @import("hls_segmentation_mode.zig").HlsSegmentationMode;
const HlsStreamInfResolution = @import("hls_stream_inf_resolution.zig").HlsStreamInfResolution;
const HlsTimedMetadataId3Frame = @import("hls_timed_metadata_id_3_frame.zig").HlsTimedMetadataId3Frame;
const HlsTsFileMode = @import("hls_ts_file_mode.zig").HlsTsFileMode;

/// Hls Group Settings
pub const HlsGroupSettings = struct {
    /// Choose one or more ad marker types to pass SCTE35 signals through to this
    /// group of Apple HLS outputs.
    ad_markers: ?[]const HlsAdMarkers = null,

    /// A partial URI prefix that will be prepended to each output in the media
    /// .m3u8 file. Can be used if base manifest is delivered from a different URL
    /// than the main .m3u8 file.
    base_url_content: ?[]const u8 = null,

    /// Optional. One value per output group.
    ///
    /// This field is required only if you are completing Base URL content A, and
    /// the downstream system has notified you that the media files for pipeline 1
    /// of all outputs are in a location different from the media files for pipeline
    /// 0.
    base_url_content_1: ?[]const u8 = null,

    /// A partial URI prefix that will be prepended to each output in the media
    /// .m3u8 file. Can be used if base manifest is delivered from a different URL
    /// than the main .m3u8 file.
    base_url_manifest: ?[]const u8 = null,

    /// Optional. One value per output group.
    ///
    /// Complete this field only if you are completing Base URL manifest A, and the
    /// downstream system has notified you that the child manifest files for
    /// pipeline 1 of all outputs are in a location different from the child
    /// manifest files for pipeline 0.
    base_url_manifest_1: ?[]const u8 = null,

    /// Mapping of up to 4 caption channels to caption languages. Is only meaningful
    /// if captionLanguageSetting is set to "insert".
    caption_language_mappings: ?[]const CaptionLanguageMapping = null,

    /// Applies only to 608 Embedded output captions.
    /// insert: Include CLOSED-CAPTIONS lines in the manifest. Specify at least one
    /// language in the CC1 Language Code field. One CLOSED-CAPTION line is added
    /// for each Language Code you specify. Make sure to specify the languages in
    /// the order in which they appear in the original source (if the source is
    /// embedded format) or the order of the caption selectors (if the source is
    /// other than embedded). Otherwise, languages in the manifest will not match up
    /// properly with the output captions.
    /// none: Include CLOSED-CAPTIONS=NONE line in the manifest.
    /// omit: Omit any CLOSED-CAPTIONS line from the manifest.
    caption_language_setting: ?HlsCaptionLanguageSetting = null,

    /// When set to "disabled", sets the #EXT-X-ALLOW-CACHE:no tag in the manifest,
    /// which prevents clients from saving media segments for later replay.
    client_cache: ?HlsClientCache = null,

    /// Specification to use (RFC-6381 or the default RFC-4281) during m3u8 playlist
    /// generation.
    codec_specification: ?HlsCodecSpecification = null,

    /// For use with encryptionType. This is a 128-bit, 16-byte hex value
    /// represented by a 32-character text string. If ivSource is set to "explicit"
    /// then this parameter is required and is used as the IV for encryption.
    constant_iv: ?[]const u8 = null,

    /// A directory or HTTP destination for the HLS segments, manifest files, and
    /// encryption keys (if enabled).
    destination: OutputLocationRef,

    /// Place segments in subdirectories.
    directory_structure: ?HlsDirectoryStructure = null,

    /// Specifies whether to insert EXT-X-DISCONTINUITY tags in the HLS child
    /// manifests for this output group.
    /// Typically, choose Insert because these tags are required in the manifest
    /// (according to the HLS specification) and serve an important purpose.
    /// Choose Never Insert only if the downstream system is doing real-time
    /// failover (without using the MediaLive automatic failover feature) and only
    /// if that downstream system has advised you to exclude the tags.
    discontinuity_tags: ?HlsDiscontinuityTags = null,

    /// Encrypts the segments with the given encryption scheme. Exclude this
    /// parameter if no encryption is desired.
    encryption_type: ?HlsEncryptionType = null,

    /// Parameters that control interactions with the CDN.
    hls_cdn_settings: ?HlsCdnSettings = null,

    /// State of HLS ID3 Segment Tagging
    hls_id_3_segment_tagging: ?HlsId3SegmentTaggingState = null,

    /// DISABLED: Do not create an I-frame-only manifest, but do create the master
    /// and media manifests (according to the Output Selection field).
    ///
    /// STANDARD: Create an I-frame-only manifest for each output that contains
    /// video, as well as the other manifests (according to the Output Selection
    /// field). The I-frame manifest contains a #EXT-X-I-FRAMES-ONLY tag to indicate
    /// it is I-frame only, and one or more #EXT-X-BYTERANGE entries identifying the
    /// I-frame position. For example, #EXT-X-BYTERANGE:160364@1461888"
    i_frame_only_playlists: ?IFrameOnlyPlaylistType = null,

    /// Specifies whether to include the final (incomplete) segment in the media
    /// output when the pipeline stops producing output because of a channel stop, a
    /// channel pause or a loss of input to the pipeline.
    /// Auto means that MediaLive decides whether to include the final segment,
    /// depending on the channel class and the types of output groups.
    /// Suppress means to never include the incomplete segment. We recommend you
    /// choose Auto and let MediaLive control the behavior.
    incomplete_segment_behavior: ?HlsIncompleteSegmentBehavior = null,

    /// Applies only if Mode field is LIVE.
    ///
    /// Specifies the maximum number of segments in the media manifest file. After
    /// this maximum, older segments are removed from the media manifest. This
    /// number must be smaller than the number in the Keep Segments field.
    index_n_segments: ?i32 = null,

    /// Parameter that control output group behavior on input loss.
    input_loss_action: ?InputLossActionForHlsOut = null,

    /// For use with encryptionType. The IV (Initialization Vector) is a 128-bit
    /// number used in conjunction with the key for encrypting blocks. If set to
    /// "include", IV is listed in the manifest, otherwise the IV is not in the
    /// manifest.
    iv_in_manifest: ?HlsIvInManifest = null,

    /// For use with encryptionType. The IV (Initialization Vector) is a 128-bit
    /// number used in conjunction with the key for encrypting blocks. If this
    /// setting is "followsSegmentNumber", it will cause the IV to change every
    /// segment (to match the segment number). If this is set to "explicit", you
    /// must enter a constantIv value.
    iv_source: ?HlsIvSource = null,

    /// Applies only if Mode field is LIVE.
    ///
    /// Specifies the number of media segments to retain in the destination
    /// directory. This number should be bigger than indexNSegments (Num segments).
    /// We recommend (value = (2 x indexNsegments) + 1).
    ///
    /// If this "keep segments" number is too low, the following might happen: the
    /// player is still reading a media manifest file that lists this segment, but
    /// that segment has been removed from the destination directory (as directed by
    /// indexNSegments). This situation would result in a 404 HTTP error on the
    /// player.
    keep_segments: ?i32 = null,

    /// The value specifies how the key is represented in the resource identified by
    /// the URI. If parameter is absent, an implicit value of "identity" is used. A
    /// reverse DNS string can also be given.
    key_format: ?[]const u8 = null,

    /// Either a single positive integer version value or a slash delimited list of
    /// version values (1/2/3).
    key_format_versions: ?[]const u8 = null,

    /// The key provider settings.
    key_provider_settings: ?KeyProviderSettings = null,

    /// When set to gzip, compresses HLS playlist.
    manifest_compression: ?HlsManifestCompression = null,

    /// Indicates whether the output manifest should use floating point or integer
    /// values for segment duration.
    manifest_duration_format: ?HlsManifestDurationFormat = null,

    /// Minimum length of MPEG-2 Transport Stream segments in seconds. When set,
    /// minimum segment length is enforced by looking ahead and back within the
    /// specified range for a nearby avail and extending the segment size if needed.
    min_segment_length: ?i32 = null,

    /// If "vod", all segments are indexed and kept permanently in the destination
    /// and manifest. If "live", only the number segments specified in keepSegments
    /// and indexNSegments are kept; newer segments replace older segments, which
    /// may prevent players from rewinding all the way to the beginning of the
    /// event.
    ///
    /// VOD mode uses HLS EXT-X-PLAYLIST-TYPE of EVENT while the channel is running,
    /// converting it to a "VOD" type manifest on completion of the stream.
    mode: ?HlsMode = null,

    /// MANIFESTS_AND_SEGMENTS: Generates manifests (master manifest, if applicable,
    /// and media manifests) for this output group.
    ///
    /// VARIANT_MANIFESTS_AND_SEGMENTS: Generates media manifests for this output
    /// group, but not a master manifest.
    ///
    /// SEGMENTS_ONLY: Does not generate any manifests for this output group.
    output_selection: ?HlsOutputSelection = null,

    /// Includes or excludes EXT-X-PROGRAM-DATE-TIME tag in .m3u8 manifest files.
    /// The value is calculated using the program date time clock.
    program_date_time: ?HlsProgramDateTime = null,

    /// Specifies the algorithm used to drive the HLS EXT-X-PROGRAM-DATE-TIME clock.
    /// Options include:
    ///
    /// INITIALIZE_FROM_OUTPUT_TIMECODE: The PDT clock is initialized as a function
    /// of the first output timecode, then incremented by the EXTINF duration of
    /// each encoded segment.
    ///
    /// SYSTEM_CLOCK: The PDT clock is initialized as a function of the UTC wall
    /// clock, then incremented by the EXTINF duration of each encoded segment. If
    /// the PDT clock diverges from the wall clock by more than 500ms, it is
    /// resynchronized to the wall clock.
    program_date_time_clock: ?HlsProgramDateTimeClock = null,

    /// Period of insertion of EXT-X-PROGRAM-DATE-TIME entry, in seconds.
    program_date_time_period: ?i32 = null,

    /// ENABLED: The master manifest (.m3u8 file) for each pipeline includes
    /// information about both pipelines: first its own media files, then the media
    /// files of the other pipeline. This feature allows playout device that support
    /// stale manifest detection to switch from one manifest to the other, when the
    /// current manifest seems to be stale. There are still two destinations and two
    /// master manifests, but both master manifests reference the media files from
    /// both pipelines.
    ///
    /// DISABLED: The master manifest (.m3u8 file) for each pipeline includes
    /// information about its own pipeline only.
    ///
    /// For an HLS output group with MediaPackage as the destination, the DISABLED
    /// behavior is always followed. MediaPackage regenerates the manifests it
    /// serves to players so a redundant manifest from MediaLive is irrelevant.
    redundant_manifest: ?HlsRedundantManifest = null,

    /// useInputSegmentation has been deprecated. The configured segment size is
    /// always used.
    segmentation_mode: ?HlsSegmentationMode = null,

    /// Length of MPEG-2 Transport Stream segments to create in seconds. Note that
    /// segments will end on the next keyframe after this duration, so actual
    /// segment length may be longer.
    segment_length: ?i32 = null,

    /// Number of segments to write to a subdirectory before starting a new one.
    /// directoryStructure must be subdirectoryPerStream for this setting to have an
    /// effect.
    segments_per_subdirectory: ?i32 = null,

    /// Include or exclude RESOLUTION attribute for video in EXT-X-STREAM-INF tag of
    /// variant manifest.
    stream_inf_resolution: ?HlsStreamInfResolution = null,

    /// Indicates ID3 frame that has the timecode.
    timed_metadata_id_3_frame: ?HlsTimedMetadataId3Frame = null,

    /// Timed Metadata interval in seconds.
    timed_metadata_id_3_period: ?i32 = null,

    /// Provides an extra millisecond delta offset to fine tune the timestamps.
    timestamp_delta_milliseconds: ?i32 = null,

    /// SEGMENTED_FILES: Emit the program as segments - multiple .ts media files.
    ///
    /// SINGLE_FILE: Applies only if Mode field is VOD. Emit the program as a single
    /// .ts media file. The media manifest includes #EXT-X-BYTERANGE tags to index
    /// segments for playback. A typical use for this value is when sending the
    /// output to AWS Elemental MediaConvert, which can accept only a single media
    /// file. Playback while the channel is running is not guaranteed due to HTTP
    /// server caching.
    ts_file_mode: ?HlsTsFileMode = null,

    pub const json_field_names = .{
        .ad_markers = "AdMarkers",
        .base_url_content = "BaseUrlContent",
        .base_url_content_1 = "BaseUrlContent1",
        .base_url_manifest = "BaseUrlManifest",
        .base_url_manifest_1 = "BaseUrlManifest1",
        .caption_language_mappings = "CaptionLanguageMappings",
        .caption_language_setting = "CaptionLanguageSetting",
        .client_cache = "ClientCache",
        .codec_specification = "CodecSpecification",
        .constant_iv = "ConstantIv",
        .destination = "Destination",
        .directory_structure = "DirectoryStructure",
        .discontinuity_tags = "DiscontinuityTags",
        .encryption_type = "EncryptionType",
        .hls_cdn_settings = "HlsCdnSettings",
        .hls_id_3_segment_tagging = "HlsId3SegmentTagging",
        .i_frame_only_playlists = "IFrameOnlyPlaylists",
        .incomplete_segment_behavior = "IncompleteSegmentBehavior",
        .index_n_segments = "IndexNSegments",
        .input_loss_action = "InputLossAction",
        .iv_in_manifest = "IvInManifest",
        .iv_source = "IvSource",
        .keep_segments = "KeepSegments",
        .key_format = "KeyFormat",
        .key_format_versions = "KeyFormatVersions",
        .key_provider_settings = "KeyProviderSettings",
        .manifest_compression = "ManifestCompression",
        .manifest_duration_format = "ManifestDurationFormat",
        .min_segment_length = "MinSegmentLength",
        .mode = "Mode",
        .output_selection = "OutputSelection",
        .program_date_time = "ProgramDateTime",
        .program_date_time_clock = "ProgramDateTimeClock",
        .program_date_time_period = "ProgramDateTimePeriod",
        .redundant_manifest = "RedundantManifest",
        .segmentation_mode = "SegmentationMode",
        .segment_length = "SegmentLength",
        .segments_per_subdirectory = "SegmentsPerSubdirectory",
        .stream_inf_resolution = "StreamInfResolution",
        .timed_metadata_id_3_frame = "TimedMetadataId3Frame",
        .timed_metadata_id_3_period = "TimedMetadataId3Period",
        .timestamp_delta_milliseconds = "TimestampDeltaMilliseconds",
        .ts_file_mode = "TsFileMode",
    };
};
