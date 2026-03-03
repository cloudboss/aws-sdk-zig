const AfdSignaling = @import("afd_signaling.zig").AfdSignaling;
const Av1BitDepth = @import("av_1_bit_depth.zig").Av1BitDepth;
const Av1ColorSpaceSettings = @import("av_1_color_space_settings.zig").Av1ColorSpaceSettings;
const FixedAfd = @import("fixed_afd.zig").FixedAfd;
const Av1GopSizeUnits = @import("av_1_gop_size_units.zig").Av1GopSizeUnits;
const Av1Level = @import("av_1_level.zig").Av1Level;
const Av1LookAheadRateControl = @import("av_1_look_ahead_rate_control.zig").Av1LookAheadRateControl;
const Av1RateControlMode = @import("av_1_rate_control_mode.zig").Av1RateControlMode;
const Av1SceneChangeDetect = @import("av_1_scene_change_detect.zig").Av1SceneChangeDetect;
const Av1SpatialAq = @import("av_1_spatial_aq.zig").Av1SpatialAq;
const Av1TemporalAq = @import("av_1_temporal_aq.zig").Av1TemporalAq;
const TimecodeBurninSettings = @import("timecode_burnin_settings.zig").TimecodeBurninSettings;
const Av1TimecodeInsertionBehavior = @import("av_1_timecode_insertion_behavior.zig").Av1TimecodeInsertionBehavior;

/// Av1 Settings
pub const Av1Settings = struct {
    /// Configures whether MediaLive will write AFD values into the video.
    /// AUTO: MediaLive will try to preserve the input AFD value (in cases where
    /// multiple AFD values are valid).
    /// FIXED: the AFD value will be the value configured in the fixedAfd parameter.
    /// NONE: MediaLive won't write AFD into the video
    afd_signaling: ?AfdSignaling = null,

    /// Specifies the bit depth for the output encode. Choose a value. Or leave the
    /// field empty to use the default, which is 8 bit.
    bit_depth: ?Av1BitDepth = null,

    /// Average bitrate in bits/second. Required when the rate control mode is CBR.
    /// Not used for QVBR.
    bitrate: ?i32 = null,

    /// The size of the buffer (HRD buffer model) in bits.
    buf_size: ?i32 = null,

    /// Specify the type of color space to apply or choose to pass through. The
    /// default is to pass through the color space that is in the source.
    color_space_settings: ?Av1ColorSpaceSettings = null,

    /// Complete this property only if you set the afdSignaling property to FIXED.
    /// Choose the AFD value (4 bits) to write on all frames of the video encode.
    fixed_afd: ?FixedAfd = null,

    /// The denominator for the framerate. Framerate is a fraction, for example,
    /// 24000 / 1001.
    framerate_denominator: i32,

    /// The numerator for the framerate. Framerate is a fraction, for example, 24000
    /// / 1001.
    framerate_numerator: i32,

    /// The GOP size (keyframe interval).
    /// If GopSizeUnits is frames, GopSize must be a whole number and must be
    /// greater than or equal to 1.
    /// If GopSizeUnits is seconds, GopSize must be greater than 0, but it can be a
    /// decimal.
    gop_size: ?f64 = null,

    /// Choose the units for the GOP size: FRAMES or SECONDS. For SECONDS, MediaLive
    /// converts the size into a frame count at run time.
    gop_size_units: ?Av1GopSizeUnits = null,

    /// Sets the level. This parameter is one of the properties of the encoding
    /// scheme for AV1.
    level: ?Av1Level = null,

    /// Sets the amount of lookahead. A value of LOW can decrease latency and memory
    /// usage. A value of HIGH can produce better quality for certain content.
    look_ahead_rate_control: ?Av1LookAheadRateControl = null,

    /// The maximum bitrate to assign.
    /// For recommendations, see the description for qvbrQualityLevel.
    max_bitrate: ?i32 = null,

    /// Used for QVBR rate control mode only.
    /// Optional.
    /// Enter a minimum bitrate if you want to keep the output bitrate about a
    /// threshold, in order to prevent the downstream system from de-allocating
    /// network bandwidth for this output.
    min_bitrate: ?i32 = null,

    /// Applies only if you enable SceneChangeDetect. Sets the interval between
    /// frames. This property ensures a minimum separation between repeated
    /// (cadence) I-frames and any I-frames inserted by scene change detection (SCD
    /// frames).
    /// Enter a number for the interval, measured in number of frames.
    /// If an SCD frame and a cadence frame are closer than the specified number of
    /// frames, MediaLive shrinks or stretches the GOP to include the SCD frame.
    /// Then normal cadence resumes in the next GOP. For GOP stretch to succeed, you
    /// must enable LookAheadRateControl.
    /// Note that the maximum GOP stretch = (GOP size) + (Minimum I-interval) - 1
    min_i_interval: ?i32 = null,

    /// The denominator for the output pixel aspect ratio (PAR).
    par_denominator: ?i32 = null,

    /// The numerator for the output pixel aspect ratio (PAR).
    par_numerator: ?i32 = null,

    /// Controls the target quality for the video encode. With QVBR rate control
    /// mode, the final quality is the target quality, constrained by the
    /// maxBitrate.
    /// Set values for the qvbrQualityLevel property and maxBitrate property that
    /// suit your most important viewing devices.
    /// To let MediaLive set the quality level (AUTO mode), leave the
    /// qvbrQualityLevel field empty. In this case, MediaLive uses the maximum
    /// bitrate, and the quality follows from that: more complex content might have
    /// a lower quality.
    /// Or set a target quality level and a maximum bitrate. With more complex
    /// content, MediaLive will try to achieve the target quality, but it won't
    /// exceed the maximum bitrate. With less complex content, This option will use
    /// only the bitrate needed to reach the target quality.
    /// Recommended values are:
    /// Primary screen: qvbrQualityLevel: Leave empty. maxBitrate: 4,000,000
    /// PC or tablet: qvbrQualityLevel: Leave empty. maxBitrate: 1,500,000 to
    /// 3,000,000
    /// Smartphone: qvbrQualityLevel: Leave empty. maxBitrate: 1,000,000 to
    /// 1,500,000
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
    rate_control_mode: ?Av1RateControlMode = null,

    /// Controls whether MediaLive inserts I-frames when it detects a scene change.
    /// ENABLED or DISABLED.
    scene_change_detect: ?Av1SceneChangeDetect = null,

    /// Spatial AQ makes adjustments within each frame based on spatial variation of
    /// content complexity. Enabled: MediaLive will determine the appropriate level
    /// of spatial AQ to apply. Disabled: No spatial AQ. For more information, see
    /// the topic about video adaptive quantization in the MediaLive user guide.
    spatial_aq: ?Av1SpatialAq = null,

    /// Temporal AQ makes adjustments within each frame based on variations in
    /// content complexity over time. Enabled: MediaLive will determine the
    /// appropriate level of temporal AQ to apply. Disabled: No temporal AQ. For
    /// more information, see the topic about video adaptive quantization in the
    /// MediaLive user guide.
    temporal_aq: ?Av1TemporalAq = null,

    /// Configures the timecode burn-in feature. If you enable this feature, the
    /// timecode will become part of the video.
    timecode_burnin_settings: ?TimecodeBurninSettings = null,

    /// Controls how MediaLive inserts timecodes into the video output encode.
    /// DISABLED: Do not insert timecodes.
    /// METADATA_OBU: Include timecodes. MediaLive inserts timecode metadata based
    /// on the timecode from the source specified in the Timecode Config property.
    /// The timecode metadata is a metadata OBU (Open Bitstream Unit) of type
    /// METADATA_TYPE_TIMECODE, in accordance with
    /// https://aomediacodec.github.io/av1-spec/#metadata-timecode-syntax.
    timecode_insertion: ?Av1TimecodeInsertionBehavior = null,

    pub const json_field_names = .{
        .afd_signaling = "AfdSignaling",
        .bit_depth = "BitDepth",
        .bitrate = "Bitrate",
        .buf_size = "BufSize",
        .color_space_settings = "ColorSpaceSettings",
        .fixed_afd = "FixedAfd",
        .framerate_denominator = "FramerateDenominator",
        .framerate_numerator = "FramerateNumerator",
        .gop_size = "GopSize",
        .gop_size_units = "GopSizeUnits",
        .level = "Level",
        .look_ahead_rate_control = "LookAheadRateControl",
        .max_bitrate = "MaxBitrate",
        .min_bitrate = "MinBitrate",
        .min_i_interval = "MinIInterval",
        .par_denominator = "ParDenominator",
        .par_numerator = "ParNumerator",
        .qvbr_quality_level = "QvbrQualityLevel",
        .rate_control_mode = "RateControlMode",
        .scene_change_detect = "SceneChangeDetect",
        .spatial_aq = "SpatialAq",
        .temporal_aq = "TemporalAq",
        .timecode_burnin_settings = "TimecodeBurninSettings",
        .timecode_insertion = "TimecodeInsertion",
    };
};
