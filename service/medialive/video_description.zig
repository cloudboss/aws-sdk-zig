const VideoCodecSettings = @import("video_codec_settings.zig").VideoCodecSettings;
const VideoDescriptionRespondToAfd = @import("video_description_respond_to_afd.zig").VideoDescriptionRespondToAfd;
const VideoDescriptionScalingBehavior = @import("video_description_scaling_behavior.zig").VideoDescriptionScalingBehavior;

/// Video settings for this stream.
pub const VideoDescription = struct {
    /// Video codec settings.
    codec_settings: ?VideoCodecSettings,

    /// Output video height, in pixels. Must be an even number. For most codecs, you
    /// can leave this field and width blank in order to use the height and width
    /// (resolution) from the source. Note, however, that leaving blank is not
    /// recommended. For the Frame Capture codec, height and width are required.
    height: ?i32,

    /// The name of this VideoDescription. Outputs will use this name to uniquely
    /// identify this Description. Description names should be unique within this
    /// Live Event.
    name: []const u8,

    /// Indicates how MediaLive will respond to the AFD values that might be in the
    /// input video. If you do not know what AFD signaling is, or if your downstream
    /// system has not given you guidance, choose PASSTHROUGH.
    /// RESPOND: MediaLive clips the input video using a formula that uses the AFD
    /// values (configured in afdSignaling ), the input display aspect ratio, and
    /// the output display aspect ratio. MediaLive also includes the AFD values in
    /// the output, unless the codec for this encode is FRAME_CAPTURE.
    /// PASSTHROUGH: MediaLive ignores the AFD values and does not clip the video.
    /// But MediaLive does include the values in the output.
    /// NONE: MediaLive does not clip the input video and does not include the AFD
    /// values in the output
    respond_to_afd: ?VideoDescriptionRespondToAfd,

    /// STRETCH_TO_OUTPUT configures the output position to stretch the video to the
    /// specified output resolution (height and width). This option will override
    /// any position value. DEFAULT may insert black boxes (pillar boxes or letter
    /// boxes) around the video to provide the specified output resolution.
    scaling_behavior: ?VideoDescriptionScalingBehavior,

    /// Changes the strength of the anti-alias filter used for scaling. 0 is the
    /// softest setting, 100 is the sharpest. A setting of 50 is recommended for
    /// most content.
    sharpness: ?i32,

    /// Output video width, in pixels. Must be an even number. For most codecs, you
    /// can leave this field and height blank in order to use the height and width
    /// (resolution) from the source. Note, however, that leaving blank is not
    /// recommended. For the Frame Capture codec, height and width are required.
    width: ?i32,

    pub const json_field_names = .{
        .codec_settings = "CodecSettings",
        .height = "Height",
        .name = "Name",
        .respond_to_afd = "RespondToAfd",
        .scaling_behavior = "ScalingBehavior",
        .sharpness = "Sharpness",
        .width = "Width",
    };
};
