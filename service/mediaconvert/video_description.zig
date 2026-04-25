const AfdSignaling = @import("afd_signaling.zig").AfdSignaling;
const AntiAlias = @import("anti_alias.zig").AntiAlias;
const ChromaPositionMode = @import("chroma_position_mode.zig").ChromaPositionMode;
const VideoCodecSettings = @import("video_codec_settings.zig").VideoCodecSettings;
const ColorMetadata = @import("color_metadata.zig").ColorMetadata;
const Rectangle = @import("rectangle.zig").Rectangle;
const DropFrameTimecode = @import("drop_frame_timecode.zig").DropFrameTimecode;
const RespondToAfd = @import("respond_to_afd.zig").RespondToAfd;
const ScalingBehavior = @import("scaling_behavior.zig").ScalingBehavior;
const VideoTimecodeInsertion = @import("video_timecode_insertion.zig").VideoTimecodeInsertion;
const TimecodeTrack = @import("timecode_track.zig").TimecodeTrack;
const VideoPreprocessor = @import("video_preprocessor.zig").VideoPreprocessor;

/// Settings related to video encoding of your output. The specific video
/// settings depend on the video codec that you choose.
pub const VideoDescription = struct {
    /// This setting only applies to H.264, H.265, and MPEG2 outputs. Use Insert AFD
    /// signaling to specify whether the service includes AFD values in the output
    /// video data and what those values are. * Choose None to remove all AFD values
    /// from this output. * Choose Fixed to ignore input AFD values and instead
    /// encode the value specified in the job. * Choose Auto to calculate output AFD
    /// values based on the input AFD scaler data.
    afd_signaling: ?AfdSignaling = null,

    /// The anti-alias filter is automatically applied to all outputs. The service
    /// no longer accepts the value DISABLED for AntiAlias. If you specify that in
    /// your job, the service will ignore the setting.
    anti_alias: ?AntiAlias = null,

    /// Specify the chroma sample positioning metadata for your H.264 or H.265
    /// output. To have MediaConvert automatically determine chroma positioning: We
    /// recommend that you keep the default value, Auto. To specify center
    /// positioning: Choose Force center. To specify top left positioning: Choose
    /// Force top left.
    chroma_position_mode: ?ChromaPositionMode = null,

    /// Video codec settings contains the group of settings related to video
    /// encoding. The settings in this group vary depending on the value that you
    /// choose for Video codec. For each codec enum that you choose, define the
    /// corresponding settings object. The following lists the codec enum, settings
    /// object pairs. * AV1, Av1Settings * AVC_INTRA, AvcIntraSettings *
    /// FRAME_CAPTURE, FrameCaptureSettings * GIF, GifSettings * H_264, H264Settings
    /// * H_265, H265Settings * MPEG2, Mpeg2Settings * PRORES, ProresSettings *
    /// UNCOMPRESSED, UncompressedSettings * VC3, Vc3Settings * VP8, Vp8Settings *
    /// VP9, Vp9Settings * XAVC, XavcSettings
    codec_settings: ?VideoCodecSettings = null,

    /// Choose Insert for this setting to include color metadata in this output.
    /// Choose Ignore to exclude color metadata from this output. If you don't
    /// specify a value, the service sets this to Insert by default.
    color_metadata: ?ColorMetadata = null,

    /// Use Cropping selection to specify the video area that the service will
    /// include in the output video frame.
    crop: ?Rectangle = null,

    /// Applies only to 29.97 fps outputs. When this feature is enabled, the service
    /// will use drop-frame timecode on outputs. If it is not possible to use
    /// drop-frame timecode, the system will fall back to non-drop-frame. This
    /// setting is enabled by default when Timecode insertion or Timecode track is
    /// enabled.
    drop_frame_timecode: ?DropFrameTimecode = null,

    /// Applies only if you set AFD Signaling to Fixed. Use Fixed to specify a
    /// four-bit AFD value which the service will write on all frames of this video
    /// output.
    fixed_afd: ?i32 = null,

    /// Use Height to define the video resolution height, in pixels, for this
    /// output. To use the same resolution as your input: Leave both Width and
    /// Height blank. To evenly scale from your input resolution: Leave Height blank
    /// and enter a value for Width. For example, if your input is 1920x1080 and you
    /// set Width to 1280, your output will be 1280x720.
    height: ?i32 = null,

    /// Use Selection placement to define the video area in your output frame. The
    /// area outside of the rectangle that you specify here is black.
    position: ?Rectangle = null,

    /// Use Respond to AFD to specify how the service changes the video itself in
    /// response to AFD values in the input. * Choose Respond to clip the input
    /// video frame according to the AFD value, input display aspect ratio, and
    /// output display aspect ratio. * Choose Passthrough to include the input AFD
    /// values. Do not choose this when AfdSignaling is set to NONE. A preferred
    /// implementation of this workflow is to set RespondToAfd to and set
    /// AfdSignaling to AUTO. * Choose None to remove all input AFD values from this
    /// output.
    respond_to_afd: ?RespondToAfd = null,

    /// Specify the video Scaling behavior when your output has a different
    /// resolution than your input. For more information, see
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/video-scaling.html Select
    /// Smart Cropping using Elemental Inference as your scaling behavior to have
    /// Elemental Inference automatically crop your video. Smart Crop requires a
    /// vertical output aspect ratio (1:1 is the widest aspect ratio supported).
    scaling_behavior: ?ScalingBehavior = null,

    /// Use Sharpness setting to specify the strength of anti-aliasing. This setting
    /// changes the width of the anti-alias filter kernel used for scaling.
    /// Sharpness only applies if your output resolution is different from your
    /// input resolution. 0 is the softest setting, 100 the sharpest, and 50
    /// recommended for most content.
    sharpness: ?i32 = null,

    /// Applies only to H.264, H.265, MPEG2, and ProRes outputs. Only enable
    /// Timecode insertion when the input frame rate is identical to the output
    /// frame rate. To include timecodes in this output, set Timecode insertion to
    /// PIC_TIMING_SEI. To leave them out, set it to DISABLED. Default is DISABLED.
    /// When the service inserts timecodes in an output, by default, it uses any
    /// embedded timecodes from the input. If none are present, the service will set
    /// the timecode for the first output frame to zero. To change this default
    /// behavior, adjust the settings under Timecode configuration. In the console,
    /// these settings are located under Job > Job settings > Timecode
    /// configuration. Note - Timecode source under input settings does not affect
    /// the timecodes that are inserted in the output. Source under Job settings >
    /// Timecode configuration does.
    timecode_insertion: ?VideoTimecodeInsertion = null,

    /// To include a timecode track in your MP4 output: Choose Enabled. MediaConvert
    /// writes the timecode track in the Null Media Header box (NMHD), without any
    /// timecode text formatting information. You can also specify dropframe or
    /// non-dropframe timecode under the Drop Frame Timecode setting. To not include
    /// a timecode track: Keep the default value, Disabled.
    timecode_track: ?TimecodeTrack = null,

    /// Find additional transcoding features under Preprocessors. Enable the
    /// features at each output individually. These features are disabled by
    /// default.
    video_preprocessors: ?VideoPreprocessor = null,

    /// Use Width to define the video resolution width, in pixels, for this output.
    /// To use the same resolution as your input: Leave both Width and Height blank.
    /// To evenly scale from your input resolution: Leave Width blank and enter a
    /// value for Height. For example, if your input is 1920x1080 and you set Height
    /// to 720, your output will be 1280x720.
    width: ?i32 = null,

    pub const json_field_names = .{
        .afd_signaling = "AfdSignaling",
        .anti_alias = "AntiAlias",
        .chroma_position_mode = "ChromaPositionMode",
        .codec_settings = "CodecSettings",
        .color_metadata = "ColorMetadata",
        .crop = "Crop",
        .drop_frame_timecode = "DropFrameTimecode",
        .fixed_afd = "FixedAfd",
        .height = "Height",
        .position = "Position",
        .respond_to_afd = "RespondToAfd",
        .scaling_behavior = "ScalingBehavior",
        .sharpness = "Sharpness",
        .timecode_insertion = "TimecodeInsertion",
        .timecode_track = "TimecodeTrack",
        .video_preprocessors = "VideoPreprocessors",
        .width = "Width",
    };
};
