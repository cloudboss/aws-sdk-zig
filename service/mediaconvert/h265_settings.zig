const H265AdaptiveQuantization = @import("h265_adaptive_quantization.zig").H265AdaptiveQuantization;
const H265AlternateTransferFunctionSei = @import("h265_alternate_transfer_function_sei.zig").H265AlternateTransferFunctionSei;
const BandwidthReductionFilter = @import("bandwidth_reduction_filter.zig").BandwidthReductionFilter;
const H265CodecLevel = @import("h265_codec_level.zig").H265CodecLevel;
const H265CodecProfile = @import("h265_codec_profile.zig").H265CodecProfile;
const H265Deblocking = @import("h265_deblocking.zig").H265Deblocking;
const H265DynamicSubGop = @import("h265_dynamic_sub_gop.zig").H265DynamicSubGop;
const H265EndOfStreamMarkers = @import("h265_end_of_stream_markers.zig").H265EndOfStreamMarkers;
const H265FlickerAdaptiveQuantization = @import("h265_flicker_adaptive_quantization.zig").H265FlickerAdaptiveQuantization;
const H265FramerateControl = @import("h265_framerate_control.zig").H265FramerateControl;
const H265FramerateConversionAlgorithm = @import("h265_framerate_conversion_algorithm.zig").H265FramerateConversionAlgorithm;
const H265GopBReference = @import("h265_gop_b_reference.zig").H265GopBReference;
const H265GopSizeUnits = @import("h265_gop_size_units.zig").H265GopSizeUnits;
const H265InterlaceMode = @import("h265_interlace_mode.zig").H265InterlaceMode;
const H265MvOverPictureBoundaries = @import("h265_mv_over_picture_boundaries.zig").H265MvOverPictureBoundaries;
const H265MvTemporalPredictor = @import("h265_mv_temporal_predictor.zig").H265MvTemporalPredictor;
const H265ParControl = @import("h265_par_control.zig").H265ParControl;
const FrameMetricType = @import("frame_metric_type.zig").FrameMetricType;
const H265QualityTuningLevel = @import("h265_quality_tuning_level.zig").H265QualityTuningLevel;
const H265QvbrSettings = @import("h265_qvbr_settings.zig").H265QvbrSettings;
const H265RateControlMode = @import("h265_rate_control_mode.zig").H265RateControlMode;
const H265SampleAdaptiveOffsetFilterMode = @import("h265_sample_adaptive_offset_filter_mode.zig").H265SampleAdaptiveOffsetFilterMode;
const H265ScanTypeConversionMode = @import("h265_scan_type_conversion_mode.zig").H265ScanTypeConversionMode;
const H265SceneChangeDetect = @import("h265_scene_change_detect.zig").H265SceneChangeDetect;
const H265SlowPal = @import("h265_slow_pal.zig").H265SlowPal;
const H265SpatialAdaptiveQuantization = @import("h265_spatial_adaptive_quantization.zig").H265SpatialAdaptiveQuantization;
const H265Telecine = @import("h265_telecine.zig").H265Telecine;
const H265TemporalAdaptiveQuantization = @import("h265_temporal_adaptive_quantization.zig").H265TemporalAdaptiveQuantization;
const H265TemporalIds = @import("h265_temporal_ids.zig").H265TemporalIds;
const H265TilePadding = @import("h265_tile_padding.zig").H265TilePadding;
const H265Tiles = @import("h265_tiles.zig").H265Tiles;
const H265TreeBlockSize = @import("h265_tree_block_size.zig").H265TreeBlockSize;
const H265UnregisteredSeiTimecode = @import("h265_unregistered_sei_timecode.zig").H265UnregisteredSeiTimecode;
const H265WriteMp4PackagingType = @import("h265_write_mp_4_packaging_type.zig").H265WriteMp4PackagingType;

/// Settings for H265 codec
pub const H265Settings = struct {
    /// When you set Adaptive Quantization to Auto, or leave blank, MediaConvert
    /// automatically applies quantization to improve the video quality of your
    /// output. Set Adaptive Quantization to Low, Medium, High, Higher, or Max to
    /// manually control the strength of the quantization filter. When you do, you
    /// can specify a value for Spatial Adaptive Quantization, Temporal Adaptive
    /// Quantization, and Flicker Adaptive Quantization, to further control the
    /// quantization filter. Set Adaptive Quantization to Off to apply no
    /// quantization to your output.
    adaptive_quantization: ?H265AdaptiveQuantization,

    /// Enables Alternate Transfer Function SEI message for outputs using Hybrid Log
    /// Gamma (HLG) Electro-Optical Transfer Function (EOTF).
    alternate_transfer_function_sei: ?H265AlternateTransferFunctionSei,

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

    /// H.265 Level.
    codec_level: ?H265CodecLevel,

    /// Represents the Profile and Tier, per the HEVC (H.265) specification.
    /// Selections are grouped as [Profile] / [Tier], so "Main/High" represents Main
    /// Profile with High Tier. 4:2:2 profiles are only available with the HEVC
    /// 4:2:2 License.
    codec_profile: ?H265CodecProfile,

    /// Use Deblocking to improve the video quality of your output by smoothing the
    /// edges of macroblock artifacts created during video compression. To reduce
    /// blocking artifacts at block boundaries, and improve overall video quality:
    /// Keep the default value, Enabled. To not apply any deblocking: Choose
    /// Disabled. Visible block edge artifacts might appear in the output,
    /// especially at lower bitrates.
    deblocking: ?H265Deblocking,

    /// Specify whether to allow the number of B-frames in your output GOP structure
    /// to vary or not depending on your input video content. To improve the
    /// subjective video quality of your output that has high-motion content: Leave
    /// blank or keep the default value Adaptive. MediaConvert will use fewer
    /// B-frames for high-motion video content than low-motion content. The maximum
    /// number of B- frames is limited by the value that you choose for B-frames
    /// between reference frames. To use the same number B-frames for all types of
    /// content: Choose Static.
    dynamic_sub_gop: ?H265DynamicSubGop,

    /// Optionally include or suppress markers at the end of your output that signal
    /// the end of the video stream. To include end of stream markers: Leave blank
    /// or keep the default value, Include. To not include end of stream markers:
    /// Choose Suppress. This is useful when your output will be inserted into
    /// another stream.
    end_of_stream_markers: ?H265EndOfStreamMarkers,

    /// Enable this setting to have the encoder reduce I-frame pop. I-frame pop
    /// appears as a visual flicker that can arise when the encoder saves bits by
    /// copying some macroblocks many times from frame to frame, and then refreshes
    /// them at the I-frame. When you enable this setting, the encoder updates these
    /// macroblocks slightly more often to smooth out the flicker. This setting is
    /// disabled by default. Related setting: In addition to enabling this setting,
    /// you must also set adaptiveQuantization to a value other than Off.
    flicker_adaptive_quantization: ?H265FlickerAdaptiveQuantization,

    /// Use the Framerate setting to specify the frame rate for this output. If you
    /// want to keep the same frame rate as the input video, choose Follow source.
    /// If you want to do frame rate conversion, choose a frame rate from the
    /// dropdown list or choose Custom. The framerates shown in the dropdown list
    /// are decimal approximations of fractions. If you choose Custom, specify your
    /// frame rate as a fraction.
    framerate_control: ?H265FramerateControl,

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
    framerate_conversion_algorithm: ?H265FramerateConversionAlgorithm,

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
    gop_b_reference: ?H265GopBReference,

    /// Specify the relative frequency of open to closed GOPs in this output. For
    /// example, if you want to allow four open GOPs and then require a closed GOP,
    /// set this value to 5. We recommend that you have the transcoder automatically
    /// choose this value for you based on characteristics of your input video. To
    /// enable this automatic behavior, do this by keeping the default empty value.
    /// If you do explicitly specify a value, for segmented outputs, don't set this
    /// value to 0.
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
    gop_size_units: ?H265GopSizeUnits,

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
    interlace_mode: ?H265InterlaceMode,

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

    /// If you are setting up the picture as a tile, you must set this to
    /// "disabled". In all other configurations, you typically enter "enabled".
    mv_over_picture_boundaries: ?H265MvOverPictureBoundaries,

    /// If you are setting up the picture as a tile, you must set this to
    /// "disabled". In other configurations, you typically enter "enabled".
    mv_temporal_predictor: ?H265MvTemporalPredictor,

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
    /// input video for your output. To specify a different PAR, choose any value
    /// other than Follow source. When you choose SPECIFIED for this setting, you
    /// must also specify values for the parNumerator and parDenominator settings.
    par_control: ?H265ParControl,

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

    /// Optional. Use Quality tuning level to choose how you want to trade off
    /// encoding speed for output video quality. The default behavior is faster,
    /// lower quality, single-pass encoding.
    quality_tuning_level: ?H265QualityTuningLevel,

    /// Settings for quality-defined variable bitrate encoding with the H.265 codec.
    /// Use these settings only when you set QVBR for Rate control mode.
    qvbr_settings: ?H265QvbrSettings,

    /// Use this setting to specify whether this output has a variable bitrate
    /// (VBR), constant bitrate (CBR) or quality-defined variable bitrate (QVBR).
    rate_control_mode: ?H265RateControlMode,

    /// Specify Sample Adaptive Offset (SAO) filter strength. Adaptive mode
    /// dynamically selects best strength based on content
    sample_adaptive_offset_filter_mode: ?H265SampleAdaptiveOffsetFilterMode,

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
    scan_type_conversion_mode: ?H265ScanTypeConversionMode,

    /// Enable this setting to insert I-frames at scene changes that the service
    /// automatically detects. This improves video quality and is enabled by
    /// default. If this output uses QVBR, choose Transition detection for further
    /// video quality improvement. For more information about QVBR, see
    /// https://docs.aws.amazon.com/console/mediaconvert/cbr-vbr-qvbr.
    scene_change_detect: ?H265SceneChangeDetect,

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
    slow_pal: ?H265SlowPal,

    /// Keep the default value, Enabled, to adjust quantization within each frame
    /// based on spatial variation of content complexity. When you enable this
    /// feature, the encoder uses fewer bits on areas that can sustain more
    /// distortion with no noticeable visual degradation and uses more bits on areas
    /// where any small distortion will be noticeable. For example, complex textured
    /// blocks are encoded with fewer bits and smooth textured blocks are encoded
    /// with more bits. Enabling this feature will almost always improve your video
    /// quality. Note, though, that this feature doesn't take into account where the
    /// viewer's attention is likely to be. If viewers are likely to be focusing
    /// their attention on a part of the screen with a lot of complex texture, you
    /// might choose to disable this feature. Related setting: When you enable
    /// spatial adaptive quantization, set the value for Adaptive quantization
    /// depending on your content. For homogeneous content, such as cartoons and
    /// video games, set it to Low. For content with a wider variety of textures,
    /// set it to High or Higher.
    spatial_adaptive_quantization: ?H265SpatialAdaptiveQuantization,

    /// This field applies only if the Streams > Advanced > Framerate field is set
    /// to 29.970. This field works with the Streams > Advanced > Preprocessors >
    /// Deinterlacer field and the Streams > Advanced > Interlaced Mode field to
    /// identify the scan type for the output: Progressive, Interlaced, Hard
    /// Telecine or Soft Telecine. - Hard: produces 29.97i output from 23.976 input.
    /// - Soft: produces 23.976; the player converts this output to 29.97i.
    telecine: ?H265Telecine,

    /// Keep the default value, Enabled, to adjust quantization within each frame
    /// based on temporal variation of content complexity. When you enable this
    /// feature, the encoder uses fewer bits on areas of the frame that aren't
    /// moving and uses more bits on complex objects with sharp edges that move a
    /// lot. For example, this feature improves the readability of text tickers on
    /// newscasts and scoreboards on sports matches. Enabling this feature will
    /// almost always improve your video quality. Note, though, that this feature
    /// doesn't take into account where the viewer's attention is likely to be. If
    /// viewers are likely to be focusing their attention on a part of the screen
    /// that doesn't have moving objects with sharp edges, such as sports athletes'
    /// faces, you might choose to disable this feature. Related setting: When you
    /// enable temporal quantization, adjust the strength of the filter with the
    /// setting Adaptive quantization.
    temporal_adaptive_quantization: ?H265TemporalAdaptiveQuantization,

    /// Enables temporal layer identifiers in the encoded bitstream. Up to 3 layers
    /// are supported depending on GOP structure: I- and P-frames form one layer,
    /// reference B-frames can form a second layer and non-reference b-frames can
    /// form a third layer. Decoders can optionally decode only the lower temporal
    /// layers to generate a lower frame rate output. For example, given a bitstream
    /// with temporal IDs and with b-frames = 1 (i.e. IbPbPb display order), a
    /// decoder could decode all the frames for full frame rate output or only the I
    /// and P frames (lowest temporal layer) for a half frame rate output.
    temporal_ids: ?H265TemporalIds,

    /// Set this field to set up the picture as a tile. You must also set TileWidth.
    /// The tile height must result in 22 or fewer rows in the frame. The tile width
    /// must result in 20 or fewer columns in the frame. And finally, the product of
    /// the column count and row count must be 64 or less. If the tile width and
    /// height are specified, MediaConvert will override the video codec slices
    /// field with a value that MediaConvert calculates.
    tile_height: ?i32,

    /// Set to "padded" to force MediaConvert to add padding to the frame, to obtain
    /// a frame that is a whole multiple of the tile size. If you are setting up the
    /// picture as a tile, you must enter "padded". In all other configurations, you
    /// typically enter "none".
    tile_padding: ?H265TilePadding,

    /// Enable use of tiles, allowing horizontal as well as vertical subdivision of
    /// the encoded pictures.
    tiles: ?H265Tiles,

    /// Set this field to set up the picture as a tile. See TileHeight for more
    /// information.
    tile_width: ?i32,

    /// Select the tree block size used for encoding. If you enter "auto", the
    /// encoder will pick the best size. If you are setting up the picture as a
    /// tile, you must set this to 32x32. In all other configurations, you typically
    /// enter "auto".
    tree_block_size: ?H265TreeBlockSize,

    /// Inserts timecode for each frame as 4 bytes of an unregistered SEI message.
    unregistered_sei_timecode: ?H265UnregisteredSeiTimecode,

    /// If the location of parameter set NAL units doesn't matter in your workflow,
    /// ignore this setting. Use this setting only with CMAF or DASH outputs, or
    /// with standalone file outputs in an MPEG-4 container (MP4 outputs). Choose
    /// HVC1 to mark your output as HVC1. This makes your output compliant with the
    /// following specification: ISO IECJTC1 SC29 N13798 Text ISO/IEC FDIS 14496-15
    /// 3rd Edition. For these outputs, the service stores parameter set NAL units
    /// in the sample headers but not in the samples directly. For MP4 outputs, when
    /// you choose HVC1, your output video might not work properly with some
    /// downstream systems and video players. The service defaults to marking your
    /// output as HEV1. For these outputs, the service writes parameter set NAL
    /// units directly into the samples.
    write_mp_4_packaging_type: ?H265WriteMp4PackagingType,

    pub const json_field_names = .{
        .adaptive_quantization = "AdaptiveQuantization",
        .alternate_transfer_function_sei = "AlternateTransferFunctionSei",
        .bandwidth_reduction_filter = "BandwidthReductionFilter",
        .bitrate = "Bitrate",
        .codec_level = "CodecLevel",
        .codec_profile = "CodecProfile",
        .deblocking = "Deblocking",
        .dynamic_sub_gop = "DynamicSubGop",
        .end_of_stream_markers = "EndOfStreamMarkers",
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
        .mv_over_picture_boundaries = "MvOverPictureBoundaries",
        .mv_temporal_predictor = "MvTemporalPredictor",
        .number_b_frames_between_reference_frames = "NumberBFramesBetweenReferenceFrames",
        .number_reference_frames = "NumberReferenceFrames",
        .par_control = "ParControl",
        .par_denominator = "ParDenominator",
        .par_numerator = "ParNumerator",
        .per_frame_metrics = "PerFrameMetrics",
        .quality_tuning_level = "QualityTuningLevel",
        .qvbr_settings = "QvbrSettings",
        .rate_control_mode = "RateControlMode",
        .sample_adaptive_offset_filter_mode = "SampleAdaptiveOffsetFilterMode",
        .scan_type_conversion_mode = "ScanTypeConversionMode",
        .scene_change_detect = "SceneChangeDetect",
        .slices = "Slices",
        .slow_pal = "SlowPal",
        .spatial_adaptive_quantization = "SpatialAdaptiveQuantization",
        .telecine = "Telecine",
        .temporal_adaptive_quantization = "TemporalAdaptiveQuantization",
        .temporal_ids = "TemporalIds",
        .tile_height = "TileHeight",
        .tile_padding = "TilePadding",
        .tiles = "Tiles",
        .tile_width = "TileWidth",
        .tree_block_size = "TreeBlockSize",
        .unregistered_sei_timecode = "UnregisteredSeiTimecode",
        .write_mp_4_packaging_type = "WriteMp4PackagingType",
    };
};
