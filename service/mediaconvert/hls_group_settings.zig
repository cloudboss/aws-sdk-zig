const HlsAdditionalManifest = @import("hls_additional_manifest.zig").HlsAdditionalManifest;
const HlsAdMarkers = @import("hls_ad_markers.zig").HlsAdMarkers;
const HlsAudioOnlyHeader = @import("hls_audio_only_header.zig").HlsAudioOnlyHeader;
const HlsCaptionLanguageMapping = @import("hls_caption_language_mapping.zig").HlsCaptionLanguageMapping;
const HlsCaptionLanguageSetting = @import("hls_caption_language_setting.zig").HlsCaptionLanguageSetting;
const HlsCaptionSegmentLengthControl = @import("hls_caption_segment_length_control.zig").HlsCaptionSegmentLengthControl;
const HlsClientCache = @import("hls_client_cache.zig").HlsClientCache;
const HlsCodecSpecification = @import("hls_codec_specification.zig").HlsCodecSpecification;
const DestinationSettings = @import("destination_settings.zig").DestinationSettings;
const HlsDirectoryStructure = @import("hls_directory_structure.zig").HlsDirectoryStructure;
const HlsEncryptionSettings = @import("hls_encryption_settings.zig").HlsEncryptionSettings;
const HlsImageBasedTrickPlay = @import("hls_image_based_trick_play.zig").HlsImageBasedTrickPlay;
const HlsImageBasedTrickPlaySettings = @import("hls_image_based_trick_play_settings.zig").HlsImageBasedTrickPlaySettings;
const HlsManifestCompression = @import("hls_manifest_compression.zig").HlsManifestCompression;
const HlsManifestDurationFormat = @import("hls_manifest_duration_format.zig").HlsManifestDurationFormat;
const HlsOutputSelection = @import("hls_output_selection.zig").HlsOutputSelection;
const HlsProgramDateTime = @import("hls_program_date_time.zig").HlsProgramDateTime;
const HlsProgressiveWriteHlsManifest = @import("hls_progressive_write_hls_manifest.zig").HlsProgressiveWriteHlsManifest;
const HlsSegmentControl = @import("hls_segment_control.zig").HlsSegmentControl;
const HlsSegmentLengthControl = @import("hls_segment_length_control.zig").HlsSegmentLengthControl;
const HlsStreamInfResolution = @import("hls_stream_inf_resolution.zig").HlsStreamInfResolution;
const HlsTargetDurationCompatibilityMode = @import("hls_target_duration_compatibility_mode.zig").HlsTargetDurationCompatibilityMode;
const HlsTimedMetadataId3Frame = @import("hls_timed_metadata_id_3_frame.zig").HlsTimedMetadataId3Frame;

/// Settings related to your HLS output package. For more information, see
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/outputs-file-ABR.html.
pub const HlsGroupSettings = struct {
    /// By default, the service creates one top-level .m3u8 HLS manifest for each
    /// HLS output group in your job. This default manifest references every output
    /// in the output group. To create additional top-level manifests that reference
    /// a subset of the outputs in the output group, specify a list of them here.
    additional_manifests: ?[]const HlsAdditionalManifest,

    /// Choose one or more ad marker types to decorate your Apple HLS manifest. This
    /// setting does not determine whether SCTE-35 markers appear in the outputs
    /// themselves.
    ad_markers: ?[]const HlsAdMarkers,

    /// Ignore this setting unless you are using FairPlay DRM with Verimatrix and
    /// you encounter playback issues. Keep the default value, Include, to output
    /// audio-only headers. Choose Exclude to remove the audio-only headers from
    /// your audio segments.
    audio_only_header: ?HlsAudioOnlyHeader,

    /// A partial URI prefix that will be prepended to each output in the media
    /// .m3u8 file. Can be used if base manifest is delivered from a different URL
    /// than the main .m3u8 file.
    base_url: ?[]const u8,

    /// Language to be used on Caption outputs
    caption_language_mappings: ?[]const HlsCaptionLanguageMapping,

    /// Applies only to 608 Embedded output captions. Insert: Include
    /// CLOSED-CAPTIONS lines in the manifest. Specify at least one language in the
    /// CC1 Language Code field. One CLOSED-CAPTION line is added for each Language
    /// Code you specify. Make sure to specify the languages in the order in which
    /// they appear in the original source (if the source is embedded format) or the
    /// order of the caption selectors (if the source is other than embedded).
    /// Otherwise, languages in the manifest will not match up properly with the
    /// output captions. None: Include CLOSED-CAPTIONS=NONE line in the manifest.
    /// Omit: Omit any CLOSED-CAPTIONS line from the manifest.
    caption_language_setting: ?HlsCaptionLanguageSetting,

    /// Set Caption segment length control to Match video to create caption segments
    /// that align with the video segments from the first video output in this
    /// output group. For example, if the video segments are 2 seconds long, your
    /// WebVTT segments will also be 2 seconds long. Keep the default setting, Large
    /// segments to create caption segments that are 300 seconds long.
    caption_segment_length_control: ?HlsCaptionSegmentLengthControl,

    /// Disable this setting only when your workflow requires the
    /// #EXT-X-ALLOW-CACHE:no tag. Otherwise, keep the default value Enabled and
    /// control caching in your video distribution set up. For example, use the
    /// Cache-Control http header.
    client_cache: ?HlsClientCache,

    /// Specification to use (RFC-6381 or the default RFC-4281) during m3u8 playlist
    /// generation.
    codec_specification: ?HlsCodecSpecification,

    /// Use Destination to specify the S3 output location and the output filename
    /// base. Destination accepts format identifiers. If you do not specify the base
    /// filename in the URI, the service will use the filename of the input file. If
    /// your job has multiple inputs, the service uses the filename of the first
    /// input file.
    destination: ?[]const u8,

    /// Settings associated with the destination. Will vary based on the type of
    /// destination
    destination_settings: ?DestinationSettings,

    /// Indicates whether segments should be placed in subdirectories.
    directory_structure: ?HlsDirectoryStructure,

    /// DRM settings.
    encryption: ?HlsEncryptionSettings,

    /// Specify whether MediaConvert generates images for trick play. Keep the
    /// default value, None, to not generate any images. Choose Thumbnail to
    /// generate tiled thumbnails. Choose Thumbnail and full frame to generate tiled
    /// thumbnails and full-resolution images of single frames. MediaConvert creates
    /// a child manifest for each set of images that you generate and adds
    /// corresponding entries to the parent manifest. A common application for these
    /// images is Roku trick mode. The thumbnails and full-frame images that
    /// MediaConvert creates with this feature are compatible with this Roku
    /// specification:
    /// https://developer.roku.com/docs/developer-program/media-playback/trick-mode/hls-and-dash.md
    image_based_trick_play: ?HlsImageBasedTrickPlay,

    /// Tile and thumbnail settings applicable when imageBasedTrickPlay is ADVANCED
    image_based_trick_play_settings: ?HlsImageBasedTrickPlaySettings,

    /// When set to GZIP, compresses HLS playlist.
    manifest_compression: ?HlsManifestCompression,

    /// Indicates whether the output manifest should use floating point values for
    /// segment duration.
    manifest_duration_format: ?HlsManifestDurationFormat,

    /// Keep this setting at the default value of 0, unless you are troubleshooting
    /// a problem with how devices play back the end of your video asset. If you
    /// know that player devices are hanging on the final segment of your video
    /// because the length of your final segment is too short, use this setting to
    /// specify a minimum final segment length, in seconds. Choose a value that is
    /// greater than or equal to 1 and less than your segment length. When you
    /// specify a value for this setting, the encoder will combine any final segment
    /// that is shorter than the length that you specify with the previous segment.
    /// For example, your segment length is 3 seconds and your final segment is .5
    /// seconds without a minimum final segment length; when you set the minimum
    /// final segment length to 1, your final segment is 3.5 seconds.
    min_final_segment_length: ?f64,

    /// When set, Minimum Segment Size is enforced by looking ahead and back within
    /// the specified range for a nearby avail and extending the segment size if
    /// needed.
    min_segment_length: ?i32,

    /// Indicates whether the .m3u8 manifest file should be generated for this HLS
    /// output group.
    output_selection: ?HlsOutputSelection,

    /// Includes or excludes EXT-X-PROGRAM-DATE-TIME tag in .m3u8 manifest files.
    /// The value is calculated as follows: either the program date and time are
    /// initialized using the input timecode source, or the time is initialized
    /// using the input timecode source and the date is initialized using the
    /// timestamp_offset.
    program_date_time: ?HlsProgramDateTime,

    /// Period of insertion of EXT-X-PROGRAM-DATE-TIME entry, in seconds.
    program_date_time_period: ?i32,

    /// Specify whether MediaConvert generates HLS manifests while your job is
    /// running or when your job is complete. To generate HLS manifests while your
    /// job is running: Choose Enabled. Use if you want to play back your content as
    /// soon as it's available. MediaConvert writes the parent and child manifests
    /// after the first three media segments are written to your destination S3
    /// bucket. It then writes new updated manifests after each additional segment
    /// is written. The parent manifest includes the latest BANDWIDTH and
    /// AVERAGE-BANDWIDTH attributes, and child manifests include the latest
    /// available media segment. When your job completes, the final child playlists
    /// include an EXT-X-ENDLIST tag. To generate HLS manifests only when your job
    /// completes: Choose Disabled.
    progressive_write_hls_manifest: ?HlsProgressiveWriteHlsManifest,

    /// When set to SINGLE_FILE, emits program as a single media resource (.ts)
    /// file, uses #EXT-X-BYTERANGE tags to index segment for playback.
    segment_control: ?HlsSegmentControl,

    /// Specify the length, in whole seconds, of each segment. When you don't
    /// specify a value, MediaConvert defaults to 10. Related settings: Use Segment
    /// length control to specify whether the encoder enforces this value strictly.
    /// Use Segment control to specify whether MediaConvert creates separate segment
    /// files or one content file that has metadata to mark the segment boundaries.
    segment_length: ?i32,

    /// Specify how you want MediaConvert to determine segment lengths in this
    /// output group. To use the exact value that you specify under Segment length:
    /// Choose Exact. Note that this might result in additional I-frames in the
    /// output GOP. To create segment lengths that are a multiple of the GOP: Choose
    /// Multiple of GOP. MediaConvert will round up the segment lengths to match the
    /// next GOP boundary. To have MediaConvert automatically determine a segment
    /// duration that is a multiple of both the audio packets and the frame rates:
    /// Choose Match. When you do, also specify a target segment duration under
    /// Segment length. This is useful for some ad-insertion or segment replacement
    /// workflows. Note that Match has the following requirements: - Output
    /// containers: Include at least one video output and at least one audio output.
    /// Audio-only outputs are not supported. - Output frame rate: Follow source is
    /// not supported. - Multiple output frame rates: When you specify multiple
    /// outputs, we recommend they share a similar frame rate (as in X/3, X/2, X, or
    /// 2X). For example: 5, 15, 30 and 60. Or: 25 and 50. (Outputs must share an
    /// integer multiple.) - Output audio codec: Specify Advanced Audio Coding
    /// (AAC). - Output sample rate: Choose 48kHz.
    segment_length_control: ?HlsSegmentLengthControl,

    /// Specify the number of segments to write to a subdirectory before starting a
    /// new one. You must also set Directory structure to Subdirectory per stream
    /// for this setting to have an effect.
    segments_per_subdirectory: ?i32,

    /// Include or exclude RESOLUTION attribute for video in EXT-X-STREAM-INF tag of
    /// variant manifest.
    stream_inf_resolution: ?HlsStreamInfResolution,

    /// When set to LEGACY, the segment target duration is always rounded up to the
    /// nearest integer value above its current value in seconds. When set to
    /// SPEC\\_COMPLIANT, the segment target duration is rounded up to the nearest
    /// integer value if fraction seconds are greater than or equal to 0.5 (>= 0.5)
    /// and rounded down if less than 0.5 (< 0.5). You may need to use LEGACY if
    /// your client needs to ensure that the target duration is always longer than
    /// the actual duration of the segment. Some older players may experience
    /// interrupted playback when the actual duration of a track in a segment is
    /// longer than the target duration.
    target_duration_compatibility_mode: ?HlsTargetDurationCompatibilityMode,

    /// Specify the type of the ID3 frame to use for ID3 timestamps in your output.
    /// To include ID3 timestamps: Specify PRIV or TDRL and set ID3 metadata to
    /// Passthrough. To exclude ID3 timestamps: Set ID3 timestamp frame type to
    /// None.
    timed_metadata_id_3_frame: ?HlsTimedMetadataId3Frame,

    /// Specify the interval in seconds to write ID3 timestamps in your output. The
    /// first timestamp starts at the output timecode and date, and increases
    /// incrementally with each ID3 timestamp. To use the default interval of 10
    /// seconds: Leave blank. To include this metadata in your output: Set ID3
    /// timestamp frame type to PRIV or TDRL, and set ID3 metadata to Passthrough.
    timed_metadata_id_3_period: ?i32,

    /// Provides an extra millisecond delta offset to fine tune the timestamps.
    timestamp_delta_milliseconds: ?i32,

    pub const json_field_names = .{
        .additional_manifests = "AdditionalManifests",
        .ad_markers = "AdMarkers",
        .audio_only_header = "AudioOnlyHeader",
        .base_url = "BaseUrl",
        .caption_language_mappings = "CaptionLanguageMappings",
        .caption_language_setting = "CaptionLanguageSetting",
        .caption_segment_length_control = "CaptionSegmentLengthControl",
        .client_cache = "ClientCache",
        .codec_specification = "CodecSpecification",
        .destination = "Destination",
        .destination_settings = "DestinationSettings",
        .directory_structure = "DirectoryStructure",
        .encryption = "Encryption",
        .image_based_trick_play = "ImageBasedTrickPlay",
        .image_based_trick_play_settings = "ImageBasedTrickPlaySettings",
        .manifest_compression = "ManifestCompression",
        .manifest_duration_format = "ManifestDurationFormat",
        .min_final_segment_length = "MinFinalSegmentLength",
        .min_segment_length = "MinSegmentLength",
        .output_selection = "OutputSelection",
        .program_date_time = "ProgramDateTime",
        .program_date_time_period = "ProgramDateTimePeriod",
        .progressive_write_hls_manifest = "ProgressiveWriteHlsManifest",
        .segment_control = "SegmentControl",
        .segment_length = "SegmentLength",
        .segment_length_control = "SegmentLengthControl",
        .segments_per_subdirectory = "SegmentsPerSubdirectory",
        .stream_inf_resolution = "StreamInfResolution",
        .target_duration_compatibility_mode = "TargetDurationCompatibilityMode",
        .timed_metadata_id_3_frame = "TimedMetadataId3Frame",
        .timed_metadata_id_3_period = "TimedMetadataId3Period",
        .timestamp_delta_milliseconds = "TimestampDeltaMilliseconds",
    };
};
