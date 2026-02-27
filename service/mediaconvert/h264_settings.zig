const H264AdaptiveQuantization = @import("h264_adaptive_quantization.zig").H264AdaptiveQuantization;
const BandwidthReductionFilter = @import("bandwidth_reduction_filter.zig").BandwidthReductionFilter;
const H264CodecLevel = @import("h264_codec_level.zig").H264CodecLevel;
const H264CodecProfile = @import("h264_codec_profile.zig").H264CodecProfile;
const H264DynamicSubGop = @import("h264_dynamic_sub_gop.zig").H264DynamicSubGop;
const H264EndOfStreamMarkers = @import("h264_end_of_stream_markers.zig").H264EndOfStreamMarkers;
const H264EntropyEncoding = @import("h264_entropy_encoding.zig").H264EntropyEncoding;
const H264FieldEncoding = @import("h264_field_encoding.zig").H264FieldEncoding;
const H264FlickerAdaptiveQuantization = @import("h264_flicker_adaptive_quantization.zig").H264FlickerAdaptiveQuantization;
const H264FramerateControl = @import("h264_framerate_control.zig").H264FramerateControl;
const H264FramerateConversionAlgorithm = @import("h264_framerate_conversion_algorithm.zig").H264FramerateConversionAlgorithm;
const H264GopBReference = @import("h264_gop_b_reference.zig").H264GopBReference;
const H264GopSizeUnits = @import("h264_gop_size_units.zig").H264GopSizeUnits;
const H264InterlaceMode = @import("h264_interlace_mode.zig").H264InterlaceMode;
const H264ParControl = @import("h264_par_control.zig").H264ParControl;
const FrameMetricType = @import("frame_metric_type.zig").FrameMetricType;
const H264QualityTuningLevel = @import("h264_quality_tuning_level.zig").H264QualityTuningLevel;
const H264QvbrSettings = @import("h264_qvbr_settings.zig").H264QvbrSettings;
const H264RateControlMode = @import("h264_rate_control_mode.zig").H264RateControlMode;
const H264RepeatPps = @import("h264_repeat_pps.zig").H264RepeatPps;
const H264SaliencyAwareEncoding = @import("h264_saliency_aware_encoding.zig").H264SaliencyAwareEncoding;
const H264ScanTypeConversionMode = @import("h264_scan_type_conversion_mode.zig").H264ScanTypeConversionMode;
const H264SceneChangeDetect = @import("h264_scene_change_detect.zig").H264SceneChangeDetect;
const H264SlowPal = @import("h264_slow_pal.zig").H264SlowPal;
const H264SpatialAdaptiveQuantization = @import("h264_spatial_adaptive_quantization.zig").H264SpatialAdaptiveQuantization;
const H264Syntax = @import("h264_syntax.zig").H264Syntax;
const H264Telecine = @import("h264_telecine.zig").H264Telecine;
const H264TemporalAdaptiveQuantization = @import("h264_temporal_adaptive_quantization.zig").H264TemporalAdaptiveQuantization;
const H264UnregisteredSeiTimecode = @import("h264_unregistered_sei_timecode.zig").H264UnregisteredSeiTimecode;
const H264WriteMp4PackagingType = @import("h264_write_mp_4_packaging_type.zig").H264WriteMp4PackagingType;

/// Required when you set Codec to the value H_264.
pub const H264Settings = struct {
    /// Keep the default value, Auto, for this setting to have MediaConvert
    /// automatically apply the best types of quantization for your video content.
    /// When you want to apply your quantization settings manually, you must set
    /// H264AdaptiveQuantization to a value other than Auto. Use this setting to
    /// specify the strength of any adaptive quantization filters that you enable.
    /// If you don't want MediaConvert to do any adaptive quantization in this
    /// transcode, set Adaptive quantization to Off. Related settings: The value
    /// that you choose here applies to the following settings:
    /// H264FlickerAdaptiveQuantization, H264SpatialAdaptiveQuantization, and
    /// H264TemporalAdaptiveQuantization.
    adaptive_quantization: ?H264AdaptiveQuantization,

    /// The Bandwidth reduction filter increases the video quality of your output
    /// relative to its bitrate. Use to lower the bitrate of your constant quality
    /// QVBR output, with little or no perceptual decrease in quality. Or, use to
    /// increase the video quality of outputs with other rate control modes relative
    /// to the bitrate that you specify. Bandwidth reduction increases further when
    /// your input is low quality or noisy. Outputs that use this feature incur
    /// pro-tier pricing. When you include Bandwidth reduction filter, you cannot
    /// include the Noise reducer preprocessor.
    bandwidth_reduction_filter: ?BandwidthReductionFilter,

    /// Specify the average bitrate in bits per second. Required for VBR and CBR.
    /// For MS Smooth outputs, bitrates must be unique when rounded down to the
    /// nearest multiple of 1000.
    bitrate: ?i32,

    /// Specify an H.264 level that is consistent with your output video settings.
    /// If you aren't sure what level to specify, choose Auto.
    codec_level: ?H264CodecLevel,

    /// H.264 Profile. High 4:2:2 and 10-bit profiles are only available with the
    /// AVC-I License.
    codec_profile: ?H264CodecProfile,

    /// Specify whether to allow the number of B-frames in your output GOP structure
    /// to vary or not depending on your input video content. To improve the
    /// subjective video quality of your output that has high-motion content: Leave
    /// blank or keep the default value Adaptive. MediaConvert will use fewer
    /// B-frames for high-motion video content than low-motion content. The maximum
    /// number of B- frames is limited by the value that you choose for B-frames
    /// between reference frames. To use the same number B-frames for all types of
    /// content: Choose Static.
    dynamic_sub_gop: ?H264DynamicSubGop,

    /// Optionally include or suppress markers at the end of your output that signal
    /// the end of the video stream. To include end of stream markers: Leave blank
    /// or keep the default value, Include. To not include end of stream markers:
    /// Choose Suppress. This is useful when your output will be inserted into
    /// another stream.
    end_of_stream_markers: ?H264EndOfStreamMarkers,

    /// Entropy encoding mode. Use CABAC (must be in Main or High profile) or CAVLC.
    entropy_encoding: ?H264EntropyEncoding,

    /// The video encoding method for your MPEG-4 AVC output. Keep the default
    /// value, PAFF, to have MediaConvert use PAFF encoding for interlaced outputs.
    /// Choose Force field to disable PAFF encoding and create separate interlaced
    /// fields. Choose MBAFF to disable PAFF and have MediaConvert use MBAFF
    /// encoding for interlaced outputs.
    field_encoding: ?H264FieldEncoding,

    /// Only use this setting when you change the default value, AUTO, for the
    /// setting H264AdaptiveQuantization. When you keep all defaults, excluding
    /// H264AdaptiveQuantization and all other adaptive quantization from your JSON
    /// job specification, MediaConvert automatically applies the best types of
    /// quantization for your video content. When you set H264AdaptiveQuantization
    /// to a value other than AUTO, the default value for
    /// H264FlickerAdaptiveQuantization is Disabled. Change this value to Enabled to
    /// reduce I-frame pop. I-frame pop appears as a visual flicker that can arise
    /// when the encoder saves bits by copying some macroblocks many times from
    /// frame to frame, and then refreshes them at the I-frame. When you enable this
    /// setting, the encoder updates these macroblocks slightly more often to smooth
    /// out the flicker. To manually enable or disable
    /// H264FlickerAdaptiveQuantization, you must set Adaptive quantization to a
    /// value other than AUTO.
    flicker_adaptive_quantization: ?H264FlickerAdaptiveQuantization,

    /// If you are using the console, use the Framerate setting to specify the frame
    /// rate for this output. If you want to keep the same frame rate as the input
    /// video, choose Follow source. If you want to do frame rate conversion, choose
    /// a frame rate from the dropdown list or choose Custom. The framerates shown
    /// in the dropdown list are decimal approximations of fractions. If you choose
    /// Custom, specify your frame rate as a fraction.
    framerate_control: ?H264FramerateControl,

    /// Choose the method that you want MediaConvert to use when increasing or
    /// decreasing your video's frame rate. For numerically simple conversions, such
    /// as 60 fps to 30 fps: We recommend that you keep the default value, Drop
    /// duplicate. For numerically complex conversions, to avoid stutter: Choose
    /// Interpolate. This results in a smooth picture, but might introduce
    /// undesirable video artifacts. For complex frame rate conversions, especially
    /// if your source video has already been converted from its original cadence:
    /// Choose FrameFormer to do motion-compensated interpolation. FrameFormer uses
    /// the best conversion method frame by frame. Note that using FrameFormer
    /// increases the transcoding time and incurs a significant add-on cost. When
    /// you choose FrameFormer, your input video resolution must be at least 128x96.
    /// To create an output with the same number of frames as your input: Choose
    /// Maintain frame count. When you do, MediaConvert will not drop, interpolate,
    /// add, or otherwise change the frame count from your input to your output.
    /// Note that since the frame count is maintained, the duration of your output
    /// will become shorter at higher frame rates and longer at lower frame rates.
    framerate_conversion_algorithm: ?H264FramerateConversionAlgorithm,

    /// When you use the API for transcode jobs that use frame rate conversion,
    /// specify the frame rate as a fraction. For example, 24000 / 1001 = 23.976
    /// fps. Use FramerateDenominator to specify the denominator of this fraction.
    /// In this example, use 1001 for the value of FramerateDenominator. When you
    /// use the console for transcode jobs that use frame rate conversion, provide
    /// the value as a decimal number for Framerate. In this example, specify
    /// 23.976.
    framerate_denominator: ?i32,

    /// When you use the API for transcode jobs that use frame rate conversion,
    /// specify the frame rate as a fraction. For example, 24000 / 1001 = 23.976
    /// fps. Use FramerateNumerator to specify the numerator of this fraction. In
    /// this example, use 24000 for the value of FramerateNumerator. When you use
    /// the console for transcode jobs that use frame rate conversion, provide the
    /// value as a decimal number for Framerate. In this example, specify 23.976.
    framerate_numerator: ?i32,

    /// Specify whether to allow B-frames to be referenced by other frame types. To
    /// use reference B-frames when your GOP structure has 1 or more B-frames: Leave
    /// blank or keep the default value Enabled. We recommend that you choose
    /// Enabled to help improve the video quality of your output relative to its
    /// bitrate. To not use reference B-frames: Choose Disabled.
    gop_b_reference: ?H264GopBReference,

    /// Specify the relative frequency of open to closed GOPs in this output. For
    /// example, if you want to allow four open GOPs and then require a closed GOP,
    /// set this value to 5. We recommend that you have the transcoder automatically
    /// choose this value for you based on characteristics of your input video. In
    /// the console, do this by keeping the default empty value. If you do
    /// explicitly specify a value, for segmented outputs, don't set this value to
    /// 0.
    gop_closed_cadence: ?i32,

    /// Use this setting only when you set GOP mode control to Specified, frames or
    /// Specified, seconds. Specify the GOP length using a whole number of frames or
    /// a decimal value of seconds. MediaConvert will interpret this value as frames
    /// or seconds depending on the value you choose for GOP mode control. If you
    /// want to allow MediaConvert to automatically determine GOP size, leave GOP
    /// size blank and set GOP mode control to Auto. If your output group specifies
    /// HLS, DASH, or CMAF, leave GOP size blank and set GOP mode control to Auto in
    /// each output in your output group.
    gop_size: ?f64,

    /// Specify how the transcoder determines GOP size for this output. We recommend
    /// that you have the transcoder automatically choose this value for you based
    /// on characteristics of your input video. To enable this automatic behavior,
    /// choose Auto and and leave GOP size blank. By default, if you don't specify
    /// GOP mode control, MediaConvert will use automatic behavior. If your output
    /// group specifies HLS, DASH, or CMAF, set GOP mode control to Auto and leave
    /// GOP size blank in each output in your output group. To explicitly specify
    /// the GOP length, choose Specified, frames or Specified, seconds and then
    /// provide the GOP length in the related setting GOP size.
    gop_size_units: ?H264GopSizeUnits,

    /// If your downstream systems have strict buffer requirements: Specify the
    /// minimum percentage of the HRD buffer that's available at the end of each
    /// encoded video segment. For the best video quality: Set to 0 or leave blank
    /// to automatically determine the final buffer fill percentage.
    hrd_buffer_final_fill_percentage: ?i32,

    /// Percentage of the buffer that should initially be filled (HRD buffer model).
    hrd_buffer_initial_fill_percentage: ?i32,

    /// Size of buffer (HRD buffer model) in bits. For example, enter five megabits
    /// as 5000000.
    hrd_buffer_size: ?i32,

    /// Choose the scan line type for the output. Keep the default value,
    /// Progressive to create a progressive output, regardless of the scan type of
    /// your input. Use Top field first or Bottom field first to create an output
    /// that's interlaced with the same field polarity throughout. Use Follow,
    /// default top or Follow, default bottom to produce outputs with the same field
    /// polarity as the source. For jobs that have multiple inputs, the output field
    /// polarity might change over the course of the output. Follow behavior depends
    /// on the input scan type. If the source is interlaced, the output will be
    /// interlaced with the same polarity as the source. If the source is
    /// progressive, the output will be interlaced with top field bottom field
    /// first, depending on which of the Follow options you choose.
    interlace_mode: ?H264InterlaceMode,

    /// Maximum bitrate in bits/second. For example, enter five megabits per second
    /// as 5000000. Required when Rate control mode is QVBR.
    max_bitrate: ?i32,

    /// Specify the minimum number of frames allowed between two IDR-frames in your
    /// output. This includes frames created at the start of a GOP or a scene
    /// change. Use Min I-Interval to improve video compression by varying GOP size
    /// when two IDR-frames would be created near each other. For example, if a
    /// regular cadence-driven IDR-frame would fall within 5 frames of a
    /// scene-change IDR-frame, and you set Min I-interval to 5, then the encoder
    /// would only write an IDR-frame for the scene-change. In this way, one GOP is
    /// shortened or extended. If a cadence-driven IDR-frame would be further than 5
    /// frames from a scene-change IDR-frame, then the encoder leaves all IDR-frames
    /// in place. To use an automatically determined interval: We recommend that you
    /// keep this value blank. This allows for MediaConvert to use an optimal
    /// setting according to the characteristics of your input video, and results in
    /// better video compression. To manually specify an interval: Enter a value
    /// from 1 to 30. Use when your downstream systems have specific GOP size
    /// requirements. To disable GOP size variance: Enter 0. MediaConvert will only
    /// create IDR-frames at the start of your output's cadence-driven GOP. Use when
    /// your downstream systems require a regular GOP size.
    min_i_interval: ?i32,

    /// Specify the number of B-frames between reference frames in this output. For
    /// the best video quality: Leave blank. MediaConvert automatically determines
    /// the number of B-frames to use based on the characteristics of your input
    /// video. To manually specify the number of B-frames between reference frames:
    /// Enter an integer from 0 to 7.
    number_b_frames_between_reference_frames: ?i32,

    /// Number of reference frames to use. The encoder may use more than requested
    /// if using B-frames and/or interlaced encoding.
    number_reference_frames: ?i32,

    /// Optional. Specify how the service determines the pixel aspect ratio (PAR)
    /// for this output. The default behavior, Follow source, uses the PAR from your
    /// input video for your output. To specify a different PAR in the console,
    /// choose any value other than Follow source. When you choose SPECIFIED for
    /// this setting, you must also specify values for the parNumerator and
    /// parDenominator settings.
    par_control: ?H264ParControl,

    /// Required when you set Pixel aspect ratio to SPECIFIED. On the console, this
    /// corresponds to any value other than Follow source. When you specify an
    /// output pixel aspect ratio (PAR) that is different from your input video PAR,
    /// provide your output PAR as a ratio. For example, for D1/DV NTSC widescreen,
    /// you would specify the ratio 40:33. In this example, the value for
    /// parDenominator is 33.
    par_denominator: ?i32,

    /// Required when you set Pixel aspect ratio to SPECIFIED. On the console, this
    /// corresponds to any value other than Follow source. When you specify an
    /// output pixel aspect ratio (PAR) that is different from your input video PAR,
    /// provide your output PAR as a ratio. For example, for D1/DV NTSC widescreen,
    /// you would specify the ratio 40:33. In this example, the value for
    /// parNumerator is 40.
    par_numerator: ?i32,

    /// Optionally choose one or more per frame metric reports to generate along
    /// with your output. You can use these metrics to analyze your video output
    /// according to one or more commonly used image quality metrics. You can
    /// specify per frame metrics for output groups or for individual outputs. When
    /// you do, MediaConvert writes a CSV (Comma-Separated Values) file to your S3
    /// output destination, named after the output name and metric type. For
    /// example: videofile_PSNR.csv Jobs that generate per frame metrics will take
    /// longer to complete, depending on the resolution and complexity of your
    /// output. For example, some 4K jobs might take up to twice as long to
    /// complete. Note that when analyzing the video quality of your output, or when
    /// comparing the video quality of multiple different outputs, we generally also
    /// recommend a detailed visual review in a controlled environment. You can
    /// choose from the following per frame metrics: * PSNR: Peak Signal-to-Noise
    /// Ratio * SSIM: Structural Similarity Index Measure * MS_SSIM: Multi-Scale
    /// Similarity Index Measure * PSNR_HVS: Peak Signal-to-Noise Ratio, Human
    /// Visual System * VMAF: Video Multi-Method Assessment Fusion * QVBR:
    /// Quality-Defined Variable Bitrate. This option is only available when your
    /// output uses the QVBR rate control mode. * SHOT_CHANGE: Shot Changes
    per_frame_metrics: ?[]const FrameMetricType,

    /// The Quality tuning level you choose represents a trade-off between the
    /// encoding speed of your job and the output video quality. For the fastest
    /// encoding speed at the cost of video quality: Choose Single pass. For a good
    /// balance between encoding speed and video quality: Leave blank or keep the
    /// default value Single pass HQ. For the best video quality, at the cost of
    /// encoding speed: Choose Multi pass HQ. MediaConvert performs an analysis pass
    /// on your input followed by an encoding pass. Outputs that use this feature
    /// incur pro-tier pricing.
    quality_tuning_level: ?H264QualityTuningLevel,

    /// Settings for quality-defined variable bitrate encoding with the H.265 codec.
    /// Use these settings only when you set QVBR for Rate control mode.
    qvbr_settings: ?H264QvbrSettings,

    /// Use this setting to specify whether this output has a variable bitrate
    /// (VBR), constant bitrate (CBR) or quality-defined variable bitrate (QVBR).
    rate_control_mode: ?H264RateControlMode,

    /// Places a PPS header on each encoded picture, even if repeated.
    repeat_pps: ?H264RepeatPps,

    /// Specify whether to apply Saliency aware encoding to your output. Use to
    /// improve the perceptual video quality of your output by allocating more
    /// encoding bits to the prominent or noticeable parts of your content. To apply
    /// saliency aware encoding, when possible: We recommend that you choose
    /// Preferred. The effects of Saliency aware encoding are best seen in lower
    /// bitrate outputs. When you choose Preferred, note that Saliency aware
    /// encoding will only apply to outputs that are 720p or higher in resolution.
    /// To not apply saliency aware encoding, prioritizing encoding speed over
    /// perceptual video quality: Choose Disabled.
    saliency_aware_encoding: ?H264SaliencyAwareEncoding,

    /// Use this setting for interlaced outputs, when your output frame rate is half
    /// of your input frame rate. In this situation, choose Optimized interlacing to
    /// create a better quality interlaced output. In this case, each progressive
    /// frame from the input corresponds to an interlaced field in the output. Keep
    /// the default value, Basic interlacing, for all other output frame rates. With
    /// basic interlacing, MediaConvert performs any frame rate conversion first and
    /// then interlaces the frames. When you choose Optimized interlacing and you
    /// set your output frame rate to a value that isn't suitable for optimized
    /// interlacing, MediaConvert automatically falls back to basic interlacing.
    /// Required settings: To use optimized interlacing, you must set Telecine to
    /// None or Soft. You can't use optimized interlacing for hard telecine outputs.
    /// You must also set Interlace mode to a value other than Progressive.
    scan_type_conversion_mode: ?H264ScanTypeConversionMode,

    /// Enable this setting to insert I-frames at scene changes that the service
    /// automatically detects. This improves video quality and is enabled by
    /// default. If this output uses QVBR, choose Transition detection for further
    /// video quality improvement. For more information about QVBR, see
    /// https://docs.aws.amazon.com/console/mediaconvert/cbr-vbr-qvbr.
    scene_change_detect: ?H264SceneChangeDetect,

    /// Number of slices per picture. Must be less than or equal to the number of
    /// macroblock rows for progressive pictures, and less than or equal to half the
    /// number of macroblock rows for interlaced pictures.
    slices: ?i32,

    /// Ignore this setting unless your input frame rate is 23.976 or 24 frames per
    /// second (fps). Enable slow PAL to create a 25 fps output. When you enable
    /// slow PAL, MediaConvert relabels the video frames to 25 fps and resamples
    /// your audio to keep it synchronized with the video. Note that enabling this
    /// setting will slightly reduce the duration of your video. Required settings:
    /// You must also set Framerate to 25.
    slow_pal: ?H264SlowPal,

    /// Ignore this setting unless you need to comply with a specification that
    /// requires a specific value. If you don't have a specification requirement, we
    /// recommend that you adjust the softness of your output by using a lower value
    /// for the setting Sharpness or by enabling a noise reducer filter. The
    /// Softness setting specifies the quantization matrices that the encoder uses.
    /// Keep the default value, 0, for flat quantization. Choose the value 1 or 16
    /// to use the default JVT softening quantization matricies from the H.264
    /// specification. Choose a value from 17 to 128 to use planar interpolation.
    /// Increasing values from 17 to 128 result in increasing reduction of
    /// high-frequency data. The value 128 results in the softest video.
    softness: ?i32,

    /// Only use this setting when you change the default value, Auto, for the
    /// setting H264AdaptiveQuantization. When you keep all defaults, excluding
    /// H264AdaptiveQuantization and all other adaptive quantization from your JSON
    /// job specification, MediaConvert automatically applies the best types of
    /// quantization for your video content. When you set H264AdaptiveQuantization
    /// to a value other than AUTO, the default value for
    /// H264SpatialAdaptiveQuantization is Enabled. Keep this default value to
    /// adjust quantization within each frame based on spatial variation of content
    /// complexity. When you enable this feature, the encoder uses fewer bits on
    /// areas that can sustain more distortion with no noticeable visual degradation
    /// and uses more bits on areas where any small distortion will be noticeable.
    /// For example, complex textured blocks are encoded with fewer bits and smooth
    /// textured blocks are encoded with more bits. Enabling this feature will
    /// almost always improve your video quality. Note, though, that this feature
    /// doesn't take into account where the viewer's attention is likely to be. If
    /// viewers are likely to be focusing their attention on a part of the screen
    /// with a lot of complex texture, you might choose to set
    /// H264SpatialAdaptiveQuantization to Disabled. Related setting: When you
    /// enable spatial adaptive quantization, set the value for Adaptive
    /// quantization depending on your content. For homogeneous content, such as
    /// cartoons and video games, set it to Low. For content with a wider variety of
    /// textures, set it to High or Higher. To manually enable or disable
    /// H264SpatialAdaptiveQuantization, you must set Adaptive quantization to a
    /// value other than AUTO.
    spatial_adaptive_quantization: ?H264SpatialAdaptiveQuantization,

    /// Produces a bitstream compliant with SMPTE RP-2027.
    syntax: ?H264Syntax,

    /// When you do frame rate conversion from 23.976 frames per second (fps) to
    /// 29.97 fps, and your output scan type is interlaced, you can optionally
    /// enable hard or soft telecine to create a smoother picture. Hard telecine
    /// produces a 29.97i output. Soft telecine produces an output with a 23.976
    /// output that signals to the video player device to do the conversion during
    /// play back. When you keep the default value, None, MediaConvert does a
    /// standard frame rate conversion to 29.97 without doing anything with the
    /// field polarity to create a smoother picture.
    telecine: ?H264Telecine,

    /// Only use this setting when you change the default value, AUTO, for the
    /// setting H264AdaptiveQuantization. When you keep all defaults, excluding
    /// H264AdaptiveQuantization and all other adaptive quantization from your JSON
    /// job specification, MediaConvert automatically applies the best types of
    /// quantization for your video content. When you set H264AdaptiveQuantization
    /// to a value other than AUTO, the default value for
    /// H264TemporalAdaptiveQuantization is Enabled. Keep this default value to
    /// adjust quantization within each frame based on temporal variation of content
    /// complexity. When you enable this feature, the encoder uses fewer bits on
    /// areas of the frame that aren't moving and uses more bits on complex objects
    /// with sharp edges that move a lot. For example, this feature improves the
    /// readability of text tickers on newscasts and scoreboards on sports matches.
    /// Enabling this feature will almost always improve your video quality. Note,
    /// though, that this feature doesn't take into account where the viewer's
    /// attention is likely to be. If viewers are likely to be focusing their
    /// attention on a part of the screen that doesn't have moving objects with
    /// sharp edges, such as sports athletes' faces, you might choose to set
    /// H264TemporalAdaptiveQuantization to Disabled. Related setting: When you
    /// enable temporal quantization, adjust the strength of the filter with the
    /// setting Adaptive quantization. To manually enable or disable
    /// H264TemporalAdaptiveQuantization, you must set Adaptive quantization to a
    /// value other than AUTO.
    temporal_adaptive_quantization: ?H264TemporalAdaptiveQuantization,

    /// Inserts timecode for each frame as 4 bytes of an unregistered SEI message.
    unregistered_sei_timecode: ?H264UnregisteredSeiTimecode,

    /// Specify how SPS and PPS NAL units are written in your output MP4 container,
    /// according to ISO/IEC 14496-15. If the location of these parameters doesn't
    /// matter in your workflow: Keep the default value, AVC1. MediaConvert writes
    /// SPS and PPS NAL units in the sample description ('stsd') box (but not into
    /// samples directly). To write SPS and PPS NAL units directly into samples (but
    /// not in the 'stsd' box): Choose AVC3. When you do, note that your output
    /// might not play properly with some downstream systems or players.
    write_mp_4_packaging_type: ?H264WriteMp4PackagingType,

    pub const json_field_names = .{
        .adaptive_quantization = "AdaptiveQuantization",
        .bandwidth_reduction_filter = "BandwidthReductionFilter",
        .bitrate = "Bitrate",
        .codec_level = "CodecLevel",
        .codec_profile = "CodecProfile",
        .dynamic_sub_gop = "DynamicSubGop",
        .end_of_stream_markers = "EndOfStreamMarkers",
        .entropy_encoding = "EntropyEncoding",
        .field_encoding = "FieldEncoding",
        .flicker_adaptive_quantization = "FlickerAdaptiveQuantization",
        .framerate_control = "FramerateControl",
        .framerate_conversion_algorithm = "FramerateConversionAlgorithm",
        .framerate_denominator = "FramerateDenominator",
        .framerate_numerator = "FramerateNumerator",
        .gop_b_reference = "GopBReference",
        .gop_closed_cadence = "GopClosedCadence",
        .gop_size = "GopSize",
        .gop_size_units = "GopSizeUnits",
        .hrd_buffer_final_fill_percentage = "HrdBufferFinalFillPercentage",
        .hrd_buffer_initial_fill_percentage = "HrdBufferInitialFillPercentage",
        .hrd_buffer_size = "HrdBufferSize",
        .interlace_mode = "InterlaceMode",
        .max_bitrate = "MaxBitrate",
        .min_i_interval = "MinIInterval",
        .number_b_frames_between_reference_frames = "NumberBFramesBetweenReferenceFrames",
        .number_reference_frames = "NumberReferenceFrames",
        .par_control = "ParControl",
        .par_denominator = "ParDenominator",
        .par_numerator = "ParNumerator",
        .per_frame_metrics = "PerFrameMetrics",
        .quality_tuning_level = "QualityTuningLevel",
        .qvbr_settings = "QvbrSettings",
        .rate_control_mode = "RateControlMode",
        .repeat_pps = "RepeatPps",
        .saliency_aware_encoding = "SaliencyAwareEncoding",
        .scan_type_conversion_mode = "ScanTypeConversionMode",
        .scene_change_detect = "SceneChangeDetect",
        .slices = "Slices",
        .slow_pal = "SlowPal",
        .softness = "Softness",
        .spatial_adaptive_quantization = "SpatialAdaptiveQuantization",
        .syntax = "Syntax",
        .telecine = "Telecine",
        .temporal_adaptive_quantization = "TemporalAdaptiveQuantization",
        .unregistered_sei_timecode = "UnregisteredSeiTimecode",
        .write_mp_4_packaging_type = "WriteMp4PackagingType",
    };
};
