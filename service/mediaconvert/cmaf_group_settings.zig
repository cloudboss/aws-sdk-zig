const CmafAdditionalManifest = @import("cmaf_additional_manifest.zig").CmafAdditionalManifest;
const CmafClientCache = @import("cmaf_client_cache.zig").CmafClientCache;
const CmafCodecSpecification = @import("cmaf_codec_specification.zig").CmafCodecSpecification;
const DashManifestStyle = @import("dash_manifest_style.zig").DashManifestStyle;
const DestinationSettings = @import("destination_settings.zig").DestinationSettings;
const CmafEncryptionSettings = @import("cmaf_encryption_settings.zig").CmafEncryptionSettings;
const CmafImageBasedTrickPlay = @import("cmaf_image_based_trick_play.zig").CmafImageBasedTrickPlay;
const CmafImageBasedTrickPlaySettings = @import("cmaf_image_based_trick_play_settings.zig").CmafImageBasedTrickPlaySettings;
const CmafManifestCompression = @import("cmaf_manifest_compression.zig").CmafManifestCompression;
const CmafManifestDurationFormat = @import("cmaf_manifest_duration_format.zig").CmafManifestDurationFormat;
const CmafMpdManifestBandwidthType = @import("cmaf_mpd_manifest_bandwidth_type.zig").CmafMpdManifestBandwidthType;
const CmafMpdProfile = @import("cmaf_mpd_profile.zig").CmafMpdProfile;
const CmafPtsOffsetHandlingForBFrames = @import("cmaf_pts_offset_handling_for_b_frames.zig").CmafPtsOffsetHandlingForBFrames;
const CmafSegmentControl = @import("cmaf_segment_control.zig").CmafSegmentControl;
const CmafSegmentLengthControl = @import("cmaf_segment_length_control.zig").CmafSegmentLengthControl;
const CmafStreamInfResolution = @import("cmaf_stream_inf_resolution.zig").CmafStreamInfResolution;
const CmafTargetDurationCompatibilityMode = @import("cmaf_target_duration_compatibility_mode.zig").CmafTargetDurationCompatibilityMode;
const CmafVideoCompositionOffsets = @import("cmaf_video_composition_offsets.zig").CmafVideoCompositionOffsets;
const CmafWriteDASHManifest = @import("cmaf_write_dash_manifest.zig").CmafWriteDASHManifest;
const CmafWriteHLSManifest = @import("cmaf_write_hls_manifest.zig").CmafWriteHLSManifest;
const CmafWriteSegmentTimelineInRepresentation = @import("cmaf_write_segment_timeline_in_representation.zig").CmafWriteSegmentTimelineInRepresentation;

/// Settings related to your CMAF output package. For more information, see
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/outputs-file-ABR.html.
pub const CmafGroupSettings = struct {
    /// By default, the service creates one top-level .m3u8 HLS manifest and one top
    /// -level .mpd DASH manifest for each CMAF output group in your job. These
    /// default manifests reference every output in the output group. To create
    /// additional top-level manifests that reference a subset of the outputs in the
    /// output group, specify a list of them here. For each additional manifest that
    /// you specify, the service creates one HLS manifest and one DASH manifest.
    additional_manifests: ?[]const CmafAdditionalManifest = null,

    /// A partial URI prefix that will be put in the manifest file at the top level
    /// BaseURL element. Can be used if streams are delivered from a different URL
    /// than the manifest file.
    base_url: ?[]const u8 = null,

    /// Disable this setting only when your workflow requires the
    /// #EXT-X-ALLOW-CACHE:no tag. Otherwise, keep the default value Enabled and
    /// control caching in your video distribution set up. For example, use the
    /// Cache-Control http header.
    client_cache: ?CmafClientCache = null,

    /// Specification to use (RFC-6381 or the default RFC-4281) during m3u8 playlist
    /// generation.
    codec_specification: ?CmafCodecSpecification = null,

    /// Specify whether MediaConvert generates I-frame only video segments for DASH
    /// trick play, also known as trick mode. When specified, the I-frame only video
    /// segments are included within an additional AdaptationSet in your DASH output
    /// manifest. To generate I-frame only video segments: Enter a name as a text
    /// string, up to 256 character long. This name is appended to the end of this
    /// output group's base filename, that you specify as part of your destination
    /// URI, and used for the I-frame only video segment files. You may also include
    /// format identifiers. For more information, see:
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/using-variables-in-your-job-settings.html#using-settings-variables-with-streaming-outputs To not generate I-frame only video segments: Leave blank.
    dash_i_frame_trick_play_name_modifier: ?[]const u8 = null,

    /// Specify how MediaConvert writes SegmentTimeline in your output DASH
    /// manifest. To write a SegmentTimeline for outputs that you also specify a
    /// Name modifier for: Keep the default value, Basic. Note that if you do not
    /// specify a name modifier for an output, MediaConvert will not write a
    /// SegmentTimeline for it. To write a common SegmentTimeline in the video
    /// AdaptationSet: Choose Compact. Note that MediaConvert will still write a
    /// SegmentTimeline in any Representation that does not share a common timeline.
    /// To write a video AdaptationSet for each different output framerate, and a
    /// common SegmentTimeline in each AdaptationSet: Choose Distinct. To write a
    /// SegmentTimeline in each AdaptationSet: Choose Full.
    dash_manifest_style: ?DashManifestStyle = null,

    /// Use Destination to specify the S3 output location and the output filename
    /// base. Destination accepts format identifiers. If you do not specify the base
    /// filename in the URI, the service will use the filename of the input file. If
    /// your job has multiple inputs, the service uses the filename of the first
    /// input file.
    destination: ?[]const u8 = null,

    /// Settings associated with the destination. Will vary based on the type of
    /// destination
    destination_settings: ?DestinationSettings = null,

    /// DRM settings.
    encryption: ?CmafEncryptionSettings = null,

    /// Specify the length, in whole seconds, of the mp4 fragments. When you don't
    /// specify a value, MediaConvert defaults to 2. Related setting: Use Fragment
    /// length control to specify whether the encoder enforces this value strictly.
    fragment_length: ?i32 = null,

    /// Specify whether MediaConvert generates images for trick play. Keep the
    /// default value, None, to not generate any images. Choose Thumbnail to
    /// generate tiled thumbnails. Choose Thumbnail and full frame to generate tiled
    /// thumbnails and full-resolution images of single frames. When you enable
    /// Write HLS manifest, MediaConvert creates a child manifest for each set of
    /// images that you generate and adds corresponding entries to the parent
    /// manifest. When you enable Write DASH manifest, MediaConvert adds an entry in
    /// the .mpd manifest for each set of images that you generate. A common
    /// application for these images is Roku trick mode. The thumbnails and
    /// full-frame images that MediaConvert creates with this feature are compatible
    /// with this Roku specification:
    /// https://developer.roku.com/docs/developer-program/media-playback/trick-mode/hls-and-dash.md
    image_based_trick_play: ?CmafImageBasedTrickPlay = null,

    /// Tile and thumbnail settings applicable when imageBasedTrickPlay is ADVANCED
    image_based_trick_play_settings: ?CmafImageBasedTrickPlaySettings = null,

    /// When set to GZIP, compresses HLS playlist.
    manifest_compression: ?CmafManifestCompression = null,

    /// Indicates whether the output manifest should use floating point values for
    /// segment duration.
    manifest_duration_format: ?CmafManifestDurationFormat = null,

    /// Minimum time of initially buffered media that is needed to ensure smooth
    /// playout.
    min_buffer_time: ?i32 = null,

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
    min_final_segment_length: ?f64 = null,

    /// Specify how the value for bandwidth is determined for each video
    /// Representation in your output MPD manifest. We recommend that you choose a
    /// MPD manifest bandwidth type that is compatible with your downstream player
    /// configuration. Max: Use the same value that you specify for Max bitrate in
    /// the video output, in bits per second. Average: Use the calculated average
    /// bitrate of the encoded video output, in bits per second.
    mpd_manifest_bandwidth_type: ?CmafMpdManifestBandwidthType = null,

    /// Specify whether your DASH profile is on-demand or main. When you choose Main
    /// profile, the service signals urn:mpeg:dash:profile:isoff-main:2011 in your
    /// .mpd DASH manifest. When you choose On-demand, the service signals
    /// urn:mpeg:dash:profile:isoff-on-demand:2011 in your .mpd. When you choose
    /// On-demand, you must also set the output group setting Segment control to
    /// Single file.
    mpd_profile: ?CmafMpdProfile = null,

    /// Use this setting only when your output video stream has B-frames, which
    /// causes the initial presentation time stamp (PTS) to be offset from the
    /// initial decode time stamp (DTS). Specify how MediaConvert handles PTS when
    /// writing time stamps in output DASH manifests. Choose Match initial PTS when
    /// you want MediaConvert to use the initial PTS as the first time stamp in the
    /// manifest. Choose Zero-based to have MediaConvert ignore the initial PTS in
    /// the video stream and instead write the initial time stamp as zero in the
    /// manifest. For outputs that don't have B-frames, the time stamps in your DASH
    /// manifests start at zero regardless of your choice here.
    pts_offset_handling_for_b_frames: ?CmafPtsOffsetHandlingForBFrames = null,

    /// When set to SINGLE_FILE, a single output file is generated, which is
    /// internally segmented using the Fragment Length and Segment Length. When set
    /// to SEGMENTED_FILES, separate segment files will be created.
    segment_control: ?CmafSegmentControl = null,

    /// Specify the length, in whole seconds, of each segment. When you don't
    /// specify a value, MediaConvert defaults to 10. Related settings: Use Segment
    /// length control to specify whether the encoder enforces this value strictly.
    /// Use Segment control to specify whether MediaConvert creates separate segment
    /// files or one content file that has metadata to mark the segment boundaries.
    segment_length: ?i32 = null,

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
    segment_length_control: ?CmafSegmentLengthControl = null,

    /// Include or exclude RESOLUTION attribute for video in EXT-X-STREAM-INF tag of
    /// variant manifest.
    stream_inf_resolution: ?CmafStreamInfResolution = null,

    /// When set to LEGACY, the segment target duration is always rounded up to the
    /// nearest integer value above its current value in seconds. When set to
    /// SPEC\\_COMPLIANT, the segment target duration is rounded up to the nearest
    /// integer value if fraction seconds are greater than or equal to 0.5 (>= 0.5)
    /// and rounded down if less than 0.5 (< 0.5). You may need to use LEGACY if
    /// your client needs to ensure that the target duration is always longer than
    /// the actual duration of the segment. Some older players may experience
    /// interrupted playback when the actual duration of a track in a segment is
    /// longer than the target duration.
    target_duration_compatibility_mode: ?CmafTargetDurationCompatibilityMode = null,

    /// Specify the video sample composition time offset mode in the output fMP4
    /// TRUN box. For wider player compatibility, set Video composition offsets to
    /// Unsigned or leave blank. The earliest presentation time may be greater than
    /// zero, and sample composition time offsets will increment using unsigned
    /// integers. For strict fMP4 video and audio timing, set Video composition
    /// offsets to Signed. The earliest presentation time will be equal to zero, and
    /// sample composition time offsets will increment using signed integers.
    video_composition_offsets: ?CmafVideoCompositionOffsets = null,

    /// When set to ENABLED, a DASH MPD manifest will be generated for this output.
    write_dash_manifest: ?CmafWriteDASHManifest = null,

    /// When set to ENABLED, an Apple HLS manifest will be generated for this
    /// output.
    write_hls_manifest: ?CmafWriteHLSManifest = null,

    /// When you enable Precise segment duration in DASH manifests, your DASH
    /// manifest shows precise segment durations. The segment duration information
    /// appears inside the SegmentTimeline element, inside SegmentTemplate at the
    /// Representation level. When this feature isn't enabled, the segment durations
    /// in your DASH manifest are approximate. The segment duration information
    /// appears in the duration attribute of the SegmentTemplate element.
    write_segment_timeline_in_representation: ?CmafWriteSegmentTimelineInRepresentation = null,

    pub const json_field_names = .{
        .additional_manifests = "AdditionalManifests",
        .base_url = "BaseUrl",
        .client_cache = "ClientCache",
        .codec_specification = "CodecSpecification",
        .dash_i_frame_trick_play_name_modifier = "DashIFrameTrickPlayNameModifier",
        .dash_manifest_style = "DashManifestStyle",
        .destination = "Destination",
        .destination_settings = "DestinationSettings",
        .encryption = "Encryption",
        .fragment_length = "FragmentLength",
        .image_based_trick_play = "ImageBasedTrickPlay",
        .image_based_trick_play_settings = "ImageBasedTrickPlaySettings",
        .manifest_compression = "ManifestCompression",
        .manifest_duration_format = "ManifestDurationFormat",
        .min_buffer_time = "MinBufferTime",
        .min_final_segment_length = "MinFinalSegmentLength",
        .mpd_manifest_bandwidth_type = "MpdManifestBandwidthType",
        .mpd_profile = "MpdProfile",
        .pts_offset_handling_for_b_frames = "PtsOffsetHandlingForBFrames",
        .segment_control = "SegmentControl",
        .segment_length = "SegmentLength",
        .segment_length_control = "SegmentLengthControl",
        .stream_inf_resolution = "StreamInfResolution",
        .target_duration_compatibility_mode = "TargetDurationCompatibilityMode",
        .video_composition_offsets = "VideoCompositionOffsets",
        .write_dash_manifest = "WriteDashManifest",
        .write_hls_manifest = "WriteHlsManifest",
        .write_segment_timeline_in_representation = "WriteSegmentTimelineInRepresentation",
    };
};
