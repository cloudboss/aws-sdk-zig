const H265AdaptiveQuantization = @import("h265_adaptive_quantization.zig").H265AdaptiveQuantization;
const AfdSignaling = @import("afd_signaling.zig").AfdSignaling;
const H265AlternativeTransferFunction = @import("h265_alternative_transfer_function.zig").H265AlternativeTransferFunction;
const H265ColorMetadata = @import("h265_color_metadata.zig").H265ColorMetadata;
const H265ColorSpaceSettings = @import("h265_color_space_settings.zig").H265ColorSpaceSettings;
const H265Deblocking = @import("h265_deblocking.zig").H265Deblocking;
const H265FilterSettings = @import("h265_filter_settings.zig").H265FilterSettings;
const FixedAfd = @import("fixed_afd.zig").FixedAfd;
const H265FlickerAq = @import("h265_flicker_aq.zig").H265FlickerAq;
const H265GopBReference = @import("h265_gop_b_reference.zig").H265GopBReference;
const H265GopSizeUnits = @import("h265_gop_size_units.zig").H265GopSizeUnits;
const H265Level = @import("h265_level.zig").H265Level;
const H265LookAheadRateControl = @import("h265_look_ahead_rate_control.zig").H265LookAheadRateControl;
const H265MvOverPictureBoundaries = @import("h265_mv_over_picture_boundaries.zig").H265MvOverPictureBoundaries;
const H265MvTemporalPredictor = @import("h265_mv_temporal_predictor.zig").H265MvTemporalPredictor;
const H265Profile = @import("h265_profile.zig").H265Profile;
const H265RateControlMode = @import("h265_rate_control_mode.zig").H265RateControlMode;
const H265ScanType = @import("h265_scan_type.zig").H265ScanType;
const H265SceneChangeDetect = @import("h265_scene_change_detect.zig").H265SceneChangeDetect;
const H265SubGopLength = @import("h265_sub_gop_length.zig").H265SubGopLength;
const H265Tier = @import("h265_tier.zig").H265Tier;
const H265TilePadding = @import("h265_tile_padding.zig").H265TilePadding;
const TimecodeBurninSettings = @import("timecode_burnin_settings.zig").TimecodeBurninSettings;
const H265TimecodeInsertionBehavior = @import("h265_timecode_insertion_behavior.zig").H265TimecodeInsertionBehavior;
const H265TreeblockSize = @import("h265_treeblock_size.zig").H265TreeblockSize;

/// H265 Settings
pub const H265Settings = struct {
    /// Enables or disables adaptive quantization (AQ), which is a technique
    /// MediaLive can apply to video on a frame-by-frame basis to produce more
    /// compression without losing quality. There are three types of adaptive
    /// quantization: spatial, temporal, and flicker. Flicker is the only type that
    /// you can customize. We recommend that you set the field to Auto. For more
    /// information about all the options, see the topic about video adaptive
    /// quantization in the MediaLive user guide.
    adaptive_quantization: ?H265AdaptiveQuantization = null,

    /// Indicates that AFD values will be written into the output stream. If
    /// afdSignaling is "auto", the system will try to preserve the input AFD value
    /// (in cases where multiple AFD values are valid). If set to "fixed", the AFD
    /// value will be the value configured in the fixedAfd parameter.
    afd_signaling: ?AfdSignaling = null,

    /// Whether or not EML should insert an Alternative Transfer Function SEI
    /// message to support backwards compatibility with non-HDR decoders and
    /// displays.
    alternative_transfer_function: ?H265AlternativeTransferFunction = null,

    /// Average bitrate in bits/second. Required when the rate control mode is VBR
    /// or CBR. Not used for QVBR. In an MS Smooth output group, each output must
    /// have a unique value when its bitrate is rounded down to the nearest multiple
    /// of 1000.
    bitrate: ?i32 = null,

    /// Size of buffer (HRD buffer model) in bits.
    buf_size: ?i32 = null,

    /// Includes colorspace metadata in the output.
    color_metadata: ?H265ColorMetadata = null,

    /// Specify the type of color space to apply or choose to pass through. The
    /// default is to pass through the color space that is in the source.
    color_space_settings: ?H265ColorSpaceSettings = null,

    /// Enable or disable the deblocking filter for this codec. The filter reduces
    /// blocking artifacts at block boundaries,
    /// which improves overall video quality. If the filter is disabled, visible
    /// block edges might appear in the output,
    /// especially at lower bitrates.
    deblocking: ?H265Deblocking = null,

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
    filter_settings: ?H265FilterSettings = null,

    /// Four bit AFD value to write on all frames of video in the output stream.
    /// Only valid when afdSignaling is set to 'Fixed'.
    fixed_afd: ?FixedAfd = null,

    /// Flicker AQ makes adjustments within each frame to reduce flicker or 'pop' on
    /// I-frames. The value to enter in this field depends on the value in the
    /// Adaptive quantization field. For more information, see the topic about video
    /// adaptive quantization in the MediaLive user guide.
    flicker_aq: ?H265FlickerAq = null,

    /// Framerate denominator.
    framerate_denominator: i32,

    /// Framerate numerator - framerate is a fraction, e.g. 24000 / 1001 = 23.976
    /// fps.
    framerate_numerator: i32,

    /// Allows the encoder to use a B-Frame as a reference frame as well.
    /// ENABLED: B-frames will also serve as reference frames.
    /// DISABLED: B-frames won't be reference frames.
    /// Must be DISABLED if resolution is greater than 1080p or when using tiled
    /// hevc encoding.
    gop_b_reference: ?H265GopBReference = null,

    /// Frequency of closed GOPs. In streaming applications, it is recommended that
    /// this be set to 1 so a decoder joining mid-stream will receive an IDR frame
    /// as quickly as possible. Setting this value to 0 will break output
    /// segmenting.
    gop_closed_cadence: ?i32 = null,

    /// Sets the number of B-frames between reference frames.
    /// Set to 2 if resolution is greater than 1080p or when using tiled hevc
    /// encoding.
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
    gop_size_units: ?H265GopSizeUnits = null,

    /// H.265 Level.
    level: ?H265Level = null,

    /// Amount of lookahead. A value of low can decrease latency and memory usage,
    /// while high can produce better quality for certain content.
    look_ahead_rate_control: ?H265LookAheadRateControl = null,

    /// For QVBR: See the tooltip for Quality level
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

    /// If you are setting up the picture as a tile, you must set this to
    /// "disabled". In all other configurations, you typically enter "enabled".
    mv_over_picture_boundaries: ?H265MvOverPictureBoundaries = null,

    /// If you are setting up the picture as a tile, you must set this to
    /// "disabled". In other configurations, you typically enter "enabled".
    mv_temporal_predictor: ?H265MvTemporalPredictor = null,

    /// Pixel Aspect Ratio denominator.
    par_denominator: ?i32 = null,

    /// Pixel Aspect Ratio numerator.
    par_numerator: ?i32 = null,

    /// H.265 Profile.
    profile: ?H265Profile = null,

    /// Controls the target quality for the video encode. Applies only when the rate
    /// control mode is QVBR. Set values for the QVBR quality level field and Max
    /// bitrate field that suit your most important viewing devices. Recommended
    /// values are:
    /// - Primary screen: Quality level: 8 to 10. Max bitrate: 4M
    /// - PC or tablet: Quality level: 7. Max bitrate: 1.5M to 3M
    /// - Smartphone: Quality level: 6. Max bitrate: 1M to 1.5M
    qvbr_quality_level: ?i32 = null,

    /// Rate control mode.
    ///
    /// QVBR: Quality will match the specified quality level except when it is
    /// constrained by the
    /// maximum bitrate. Recommended if you or your viewers pay for bandwidth.
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
    rate_control_mode: ?H265RateControlMode = null,

    /// Sets the scan type of the output to progressive or top-field-first
    /// interlaced.
    scan_type: ?H265ScanType = null,

    /// Scene change detection.
    scene_change_detect: ?H265SceneChangeDetect = null,

    /// Number of slices per picture. Must be less than or equal to the number of
    /// macroblock rows for progressive pictures, and less than or equal to half the
    /// number of macroblock rows for interlaced pictures.
    /// This field is optional; when no value is specified the encoder will choose
    /// the number of slices based on encode resolution.
    slices: ?i32 = null,

    /// Sets the number of B-frames in each sub-GOP.
    /// FIXED: Use the value in Num B-frames.
    /// DYNAMIC: Optimizes the number of B-frames in each sub-GOP to improve visual
    /// quality.
    /// Must be FIXED if resolution is greater than 1080p or when using tiled hevc
    /// encoding.
    subgop_length: ?H265SubGopLength = null,

    /// H.265 Tier.
    tier: ?H265Tier = null,

    /// Set this field to set up the picture as a tile. You must also set tileWidth.
    /// The tile height must result in 22 or fewer rows in the frame. The tile width
    /// must result in 20 or fewer columns in the frame. And finally, the product of
    /// the
    /// column count and row count must be 64 of less.
    /// If the tile width and height are specified, MediaLive will override the
    /// video
    /// codec slices field with a value that MediaLive calculates
    tile_height: ?i32 = null,

    /// Set to "padded" to force MediaLive to add padding to the frame, to obtain a
    /// frame that is a whole multiple of the tile size.
    /// If you are setting up the picture as a tile, you must enter "padded".
    /// In all other configurations, you typically enter "none".
    tile_padding: ?H265TilePadding = null,

    /// Set this field to set up the picture as a tile. See tileHeight for more
    /// information.
    tile_width: ?i32 = null,

    /// Timecode burn-in settings
    timecode_burnin_settings: ?TimecodeBurninSettings = null,

    /// Determines how timecodes should be inserted into the video elementary
    /// stream.
    /// - 'disabled': Do not include timecodes
    /// - 'picTimingSei': Pass through picture timing SEI messages from the source
    /// specified in Timecode Config
    timecode_insertion: ?H265TimecodeInsertionBehavior = null,

    /// Select the tree block size used for encoding. If you enter "auto", the
    /// encoder will pick the best size. If you are setting up the picture as a
    /// tile, you must set this to 32x32. In all other configurations, you typically
    /// enter "auto".
    treeblock_size: ?H265TreeblockSize = null,

    pub const json_field_names = .{
        .adaptive_quantization = "AdaptiveQuantization",
        .afd_signaling = "AfdSignaling",
        .alternative_transfer_function = "AlternativeTransferFunction",
        .bitrate = "Bitrate",
        .buf_size = "BufSize",
        .color_metadata = "ColorMetadata",
        .color_space_settings = "ColorSpaceSettings",
        .deblocking = "Deblocking",
        .filter_settings = "FilterSettings",
        .fixed_afd = "FixedAfd",
        .flicker_aq = "FlickerAq",
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
        .mv_over_picture_boundaries = "MvOverPictureBoundaries",
        .mv_temporal_predictor = "MvTemporalPredictor",
        .par_denominator = "ParDenominator",
        .par_numerator = "ParNumerator",
        .profile = "Profile",
        .qvbr_quality_level = "QvbrQualityLevel",
        .rate_control_mode = "RateControlMode",
        .scan_type = "ScanType",
        .scene_change_detect = "SceneChangeDetect",
        .slices = "Slices",
        .subgop_length = "SubgopLength",
        .tier = "Tier",
        .tile_height = "TileHeight",
        .tile_padding = "TilePadding",
        .tile_width = "TileWidth",
        .timecode_burnin_settings = "TimecodeBurninSettings",
        .timecode_insertion = "TimecodeInsertion",
        .treeblock_size = "TreeblockSize",
    };
};
