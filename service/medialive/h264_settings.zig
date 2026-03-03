const H264AdaptiveQuantization = @import("h264_adaptive_quantization.zig").H264AdaptiveQuantization;
const AfdSignaling = @import("afd_signaling.zig").AfdSignaling;
const H264ColorMetadata = @import("h264_color_metadata.zig").H264ColorMetadata;
const H264ColorSpaceSettings = @import("h264_color_space_settings.zig").H264ColorSpaceSettings;
const H264EntropyEncoding = @import("h264_entropy_encoding.zig").H264EntropyEncoding;
const H264FilterSettings = @import("h264_filter_settings.zig").H264FilterSettings;
const FixedAfd = @import("fixed_afd.zig").FixedAfd;
const H264FlickerAq = @import("h264_flicker_aq.zig").H264FlickerAq;
const H264ForceFieldPictures = @import("h264_force_field_pictures.zig").H264ForceFieldPictures;
const H264FramerateControl = @import("h264_framerate_control.zig").H264FramerateControl;
const H264GopBReference = @import("h264_gop_b_reference.zig").H264GopBReference;
const H264GopSizeUnits = @import("h264_gop_size_units.zig").H264GopSizeUnits;
const H264Level = @import("h264_level.zig").H264Level;
const H264LookAheadRateControl = @import("h264_look_ahead_rate_control.zig").H264LookAheadRateControl;
const H264ParControl = @import("h264_par_control.zig").H264ParControl;
const H264Profile = @import("h264_profile.zig").H264Profile;
const H264QualityLevel = @import("h264_quality_level.zig").H264QualityLevel;
const H264RateControlMode = @import("h264_rate_control_mode.zig").H264RateControlMode;
const H264ScanType = @import("h264_scan_type.zig").H264ScanType;
const H264SceneChangeDetect = @import("h264_scene_change_detect.zig").H264SceneChangeDetect;
const H264SpatialAq = @import("h264_spatial_aq.zig").H264SpatialAq;
const H264SubGopLength = @import("h264_sub_gop_length.zig").H264SubGopLength;
const H264Syntax = @import("h264_syntax.zig").H264Syntax;
const H264TemporalAq = @import("h264_temporal_aq.zig").H264TemporalAq;
const TimecodeBurninSettings = @import("timecode_burnin_settings.zig").TimecodeBurninSettings;
const H264TimecodeInsertionBehavior = @import("h264_timecode_insertion_behavior.zig").H264TimecodeInsertionBehavior;

/// H264 Settings
pub const H264Settings = struct {
    /// Enables or disables adaptive quantization (AQ), which is a technique
    /// MediaLive can apply to video on a frame-by-frame basis to produce more
    /// compression without losing quality. There are three types of adaptive
    /// quantization: spatial, temporal, and flicker. We recommend that you set the
    /// field to Auto. For more information about all the options, see the topic
    /// about video adaptive quantization in the MediaLive user guide.
    adaptive_quantization: ?H264AdaptiveQuantization = null,

    /// Indicates that AFD values will be written into the output stream. If
    /// afdSignaling is "auto", the system will try to preserve the input AFD value
    /// (in cases where multiple AFD values are valid). If set to "fixed", the AFD
    /// value will be the value configured in the fixedAfd parameter.
    afd_signaling: ?AfdSignaling = null,

    /// Average bitrate in bits/second. Required when the rate control mode is VBR
    /// or CBR. Not used for QVBR. In an MS Smooth output group, each output must
    /// have a unique value when its bitrate is rounded down to the nearest multiple
    /// of 1000.
    bitrate: ?i32 = null,

    /// Percentage of the buffer that should initially be filled (HRD buffer model).
    buf_fill_pct: ?i32 = null,

    /// Size of buffer (HRD buffer model) in bits.
    buf_size: ?i32 = null,

    /// Includes colorspace metadata in the output.
    color_metadata: ?H264ColorMetadata = null,

    /// Specify the type of color space to apply or choose to pass through. The
    /// default is to pass through the color space that is in the source.
    color_space_settings: ?H264ColorSpaceSettings = null,

    /// Entropy encoding mode. Use cabac (must be in Main or High profile) or cavlc.
    entropy_encoding: ?H264EntropyEncoding = null,

    /// Optional. Both filters reduce bandwidth by removing imperceptible details.
    /// You can enable one of the filters. We
    /// recommend that you try both filters and observe the results to decide which
    /// one to use.
    ///
    /// The Temporal Filter reduces bandwidth by removing imperceptible details in
    /// the content. It combines perceptual
    /// filtering and motion compensated temporal filtering (MCTF). It operates
    /// independently of the compression level.
    ///
    /// The Bandwidth Reduction filter is a perceptual filter located within the
    /// encoding loop. It adapts to the current
    /// compression level to filter imperceptible signals. This filter works only
    /// when the resolution is 1080p or lower.
    filter_settings: ?H264FilterSettings = null,

    /// Four bit AFD value to write on all frames of video in the output stream.
    /// Only valid when afdSignaling is set to 'Fixed'.
    fixed_afd: ?FixedAfd = null,

    /// Flicker AQ makes adjustments within each frame to reduce flicker or 'pop' on
    /// I-frames. The value to enter in this field depends on the value in the
    /// Adaptive quantization field. For more information, see the topic about video
    /// adaptive quantization in the MediaLive user guide.
    flicker_aq: ?H264FlickerAq = null,

    /// This setting applies only when scan type is "interlaced." It controls
    /// whether coding is performed on a field basis or on a frame basis. (When the
    /// video is progressive, the coding is always performed on a frame basis.)
    /// enabled: Force MediaLive to code on a field basis, so that odd and even sets
    /// of fields are coded separately.
    /// disabled: Code the two sets of fields separately (on a field basis) or
    /// together (on a frame basis using PAFF), depending on what is most
    /// appropriate for the content.
    force_field_pictures: ?H264ForceFieldPictures = null,

    /// This field indicates how the output video frame rate is specified. If
    /// "specified" is selected then the output video frame rate is determined by
    /// framerateNumerator and framerateDenominator, else if "initializeFromSource"
    /// is selected then the output video frame rate will be set equal to the input
    /// video frame rate of the first input.
    framerate_control: ?H264FramerateControl = null,

    /// Framerate denominator.
    framerate_denominator: ?i32 = null,

    /// Framerate numerator - framerate is a fraction, e.g. 24000 / 1001 = 23.976
    /// fps.
    framerate_numerator: ?i32 = null,

    /// Documentation update needed
    gop_b_reference: ?H264GopBReference = null,

    /// Frequency of closed GOPs. In streaming applications, it is recommended that
    /// this be set to 1 so a decoder joining mid-stream will receive an IDR frame
    /// as quickly as possible. Setting this value to 0 will break output
    /// segmenting.
    gop_closed_cadence: ?i32 = null,

    /// Number of B-frames between reference frames.
    gop_num_b_frames: ?i32 = null,

    /// GOP size (keyframe interval) in units of either frames or seconds per
    /// gopSizeUnits.
    /// If gopSizeUnits is frames, gopSize must be an integer and must be greater
    /// than or equal to 1.
    /// If gopSizeUnits is seconds, gopSize must be greater than 0, but need not be
    /// an integer.
    gop_size: ?f64 = null,

    /// Indicates if the gopSize is specified in frames or seconds. If seconds the
    /// system will convert the gopSize into a frame count at run time.
    gop_size_units: ?H264GopSizeUnits = null,

    /// H.264 Level.
    level: ?H264Level = null,

    /// Amount of lookahead. A value of low can decrease latency and memory usage,
    /// while high can produce better quality for certain content.
    look_ahead_rate_control: ?H264LookAheadRateControl = null,

    /// For QVBR: See the tooltip for Quality level
    ///
    /// For VBR: Set the maximum bitrate in order to accommodate expected spikes in
    /// the complexity of the video.
    max_bitrate: ?i32 = null,

    /// Used for QVBR rate control mode only.
    /// Optional.
    /// Enter a minimum bitrate if you want to keep the output bitrate about a
    /// threshold, in order to prevent the downstream system from de-allocating
    /// network bandwidth for this output.
    min_bitrate: ?i32 = null,

    /// Only meaningful if sceneChangeDetect is set to enabled. Defaults to 5 if
    /// multiplex rate control is used. Enforces separation between repeated
    /// (cadence) I-frames and I-frames inserted by Scene Change Detection. If a
    /// scene change I-frame is within I-interval frames of a cadence I-frame, the
    /// GOP is shrunk and/or stretched to the scene change I-frame. GOP stretch
    /// requires enabling lookahead as well as setting I-interval. The normal
    /// cadence resumes for the next GOP. Note: Maximum GOP stretch = GOP size +
    /// Min-I-interval - 1
    min_i_interval: ?i32 = null,

    /// Sets the minimum QP. If you aren't familiar with quantization adjustment,
    /// leave the field empty. MediaLive will
    /// apply an appropriate value.
    min_qp: ?i32 = null,

    /// Number of reference frames to use. The encoder may use more than requested
    /// if using B-frames and/or interlaced encoding.
    num_ref_frames: ?i32 = null,

    /// This field indicates how the output pixel aspect ratio is specified. If
    /// "specified" is selected then the output video pixel aspect ratio is
    /// determined by parNumerator and parDenominator, else if
    /// "initializeFromSource" is selected then the output pixsel aspect ratio will
    /// be set equal to the input video pixel aspect ratio of the first input.
    par_control: ?H264ParControl = null,

    /// Pixel Aspect Ratio denominator.
    par_denominator: ?i32 = null,

    /// Pixel Aspect Ratio numerator.
    par_numerator: ?i32 = null,

    /// H.264 Profile.
    profile: ?H264Profile = null,

    /// Leave as STANDARD_QUALITY or choose a different value (which might result in
    /// additional costs to run the channel).
    /// - ENHANCED_QUALITY: Produces a slightly better video quality without an
    /// increase in the bitrate. Has an effect only when the Rate control mode is
    /// QVBR or CBR. If this channel is in a MediaLive multiplex, the value must be
    /// ENHANCED_QUALITY.
    /// - STANDARD_QUALITY: Valid for any Rate control mode.
    quality_level: ?H264QualityLevel = null,

    /// Controls the target quality for the video encode. Applies only when the rate
    /// control mode is QVBR. You can set a target quality or you can let MediaLive
    /// determine the best quality. To set a target quality, enter values in the
    /// QVBR quality level field and the Max bitrate field. Enter values that suit
    /// your most important viewing devices. Recommended values are:
    /// - Primary screen: Quality level: 8 to 10. Max bitrate: 4M
    /// - PC or tablet: Quality level: 7. Max bitrate: 1.5M to 3M
    /// - Smartphone: Quality level: 6. Max bitrate: 1M to 1.5M
    /// To let MediaLive decide, leave the QVBR quality level field empty, and in
    /// Max bitrate enter the maximum rate you want in the video. For more
    /// information, see the section called "Video - rate control mode" in the
    /// MediaLive user guide
    qvbr_quality_level: ?i32 = null,

    /// Rate control mode.
    ///
    /// QVBR: Quality will match the specified quality level except when it is
    /// constrained by the
    /// maximum bitrate. Recommended if you or your viewers pay for bandwidth.
    ///
    /// VBR: Quality and bitrate vary, depending on the video complexity.
    /// Recommended instead of QVBR
    /// if you want to maintain a specific average bitrate over the duration of the
    /// channel.
    ///
    /// CBR: Quality varies, depending on the video complexity. Recommended only if
    /// you distribute
    /// your assets to devices that cannot handle variable bitrates.
    ///
    /// Multiplex: This rate control mode is only supported (and is required) when
    /// the video is being
    /// delivered to a MediaLive Multiplex in which case the rate control
    /// configuration is controlled
    /// by the properties within the Multiplex Program.
    rate_control_mode: ?H264RateControlMode = null,

    /// Sets the scan type of the output to progressive or top-field-first
    /// interlaced.
    scan_type: ?H264ScanType = null,

    /// Scene change detection.
    ///
    /// - On: inserts I-frames when scene change is detected.
    /// - Off: does not force an I-frame when scene change is detected.
    scene_change_detect: ?H264SceneChangeDetect = null,

    /// Number of slices per picture. Must be less than or equal to the number of
    /// macroblock rows for progressive pictures, and less than or equal to half the
    /// number of macroblock rows for interlaced pictures.
    /// This field is optional; when no value is specified the encoder will choose
    /// the number of slices based on encode resolution.
    slices: ?i32 = null,

    /// Softness. Selects quantizer matrix, larger values reduce high-frequency
    /// content in the encoded image. If not set to zero, must be greater than 15.
    softness: ?i32 = null,

    /// Spatial AQ makes adjustments within each frame based on spatial variation of
    /// content complexity. The value to enter in this field depends on the value in
    /// the Adaptive quantization field. For more information, see the topic about
    /// video adaptive quantization in the MediaLive user guide.
    spatial_aq: ?H264SpatialAq = null,

    /// If set to fixed, use gopNumBFrames B-frames per sub-GOP. If set to dynamic,
    /// optimize the number of B-frames used for each sub-GOP to improve visual
    /// quality.
    subgop_length: ?H264SubGopLength = null,

    /// Produces a bitstream compliant with SMPTE RP-2027.
    syntax: ?H264Syntax = null,

    /// Temporal makes adjustments within each frame based on variations in content
    /// complexity over time. The value to enter in this field depends on the value
    /// in the Adaptive quantization field. For more information, see the topic
    /// about video adaptive quantization in the MediaLive user guide.
    temporal_aq: ?H264TemporalAq = null,

    /// Timecode burn-in settings
    timecode_burnin_settings: ?TimecodeBurninSettings = null,

    /// Determines how timecodes should be inserted into the video elementary
    /// stream.
    /// - 'disabled': Do not include timecodes
    /// - 'picTimingSei': Pass through picture timing SEI messages from the source
    /// specified in Timecode Config
    timecode_insertion: ?H264TimecodeInsertionBehavior = null,

    pub const json_field_names = .{
        .adaptive_quantization = "AdaptiveQuantization",
        .afd_signaling = "AfdSignaling",
        .bitrate = "Bitrate",
        .buf_fill_pct = "BufFillPct",
        .buf_size = "BufSize",
        .color_metadata = "ColorMetadata",
        .color_space_settings = "ColorSpaceSettings",
        .entropy_encoding = "EntropyEncoding",
        .filter_settings = "FilterSettings",
        .fixed_afd = "FixedAfd",
        .flicker_aq = "FlickerAq",
        .force_field_pictures = "ForceFieldPictures",
        .framerate_control = "FramerateControl",
        .framerate_denominator = "FramerateDenominator",
        .framerate_numerator = "FramerateNumerator",
        .gop_b_reference = "GopBReference",
        .gop_closed_cadence = "GopClosedCadence",
        .gop_num_b_frames = "GopNumBFrames",
        .gop_size = "GopSize",
        .gop_size_units = "GopSizeUnits",
        .level = "Level",
        .look_ahead_rate_control = "LookAheadRateControl",
        .max_bitrate = "MaxBitrate",
        .min_bitrate = "MinBitrate",
        .min_i_interval = "MinIInterval",
        .min_qp = "MinQp",
        .num_ref_frames = "NumRefFrames",
        .par_control = "ParControl",
        .par_denominator = "ParDenominator",
        .par_numerator = "ParNumerator",
        .profile = "Profile",
        .quality_level = "QualityLevel",
        .qvbr_quality_level = "QvbrQualityLevel",
        .rate_control_mode = "RateControlMode",
        .scan_type = "ScanType",
        .scene_change_detect = "SceneChangeDetect",
        .slices = "Slices",
        .softness = "Softness",
        .spatial_aq = "SpatialAq",
        .subgop_length = "SubgopLength",
        .syntax = "Syntax",
        .temporal_aq = "TemporalAq",
        .timecode_burnin_settings = "TimecodeBurninSettings",
        .timecode_insertion = "TimecodeInsertion",
    };
};
