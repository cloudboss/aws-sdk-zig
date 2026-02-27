const Av1Settings = @import("av_1_settings.zig").Av1Settings;
const AvcIntraSettings = @import("avc_intra_settings.zig").AvcIntraSettings;
const VideoCodec = @import("video_codec.zig").VideoCodec;
const FrameCaptureSettings = @import("frame_capture_settings.zig").FrameCaptureSettings;
const GifSettings = @import("gif_settings.zig").GifSettings;
const H264Settings = @import("h264_settings.zig").H264Settings;
const H265Settings = @import("h265_settings.zig").H265Settings;
const Mpeg2Settings = @import("mpeg_2_settings.zig").Mpeg2Settings;
const PassthroughSettings = @import("passthrough_settings.zig").PassthroughSettings;
const ProresSettings = @import("prores_settings.zig").ProresSettings;
const UncompressedSettings = @import("uncompressed_settings.zig").UncompressedSettings;
const Vc3Settings = @import("vc_3_settings.zig").Vc3Settings;
const Vp8Settings = @import("vp_8_settings.zig").Vp8Settings;
const Vp9Settings = @import("vp_9_settings.zig").Vp9Settings;
const XavcSettings = @import("xavc_settings.zig").XavcSettings;

/// Video codec settings contains the group of settings related to video
/// encoding. The settings in this group vary depending on the value that you
/// choose for Video codec. For each codec enum that you choose, define the
/// corresponding settings object. The following lists the codec enum, settings
/// object pairs. * AV1, Av1Settings * AVC_INTRA, AvcIntraSettings *
/// FRAME_CAPTURE, FrameCaptureSettings * GIF, GifSettings * H_264, H264Settings
/// * H_265, H265Settings * MPEG2, Mpeg2Settings * PRORES, ProresSettings *
/// UNCOMPRESSED, UncompressedSettings * VC3, Vc3Settings * VP8, Vp8Settings *
/// VP9, Vp9Settings * XAVC, XavcSettings
pub const VideoCodecSettings = struct {
    /// Required when you set Codec, under VideoDescription>CodecSettings to the
    /// value AV1.
    av_1_settings: ?Av1Settings,

    /// Required when you choose AVC-Intra for your output video codec. For more
    /// information about the AVC-Intra settings, see the relevant specification.
    /// For detailed information about SD and HD in AVC-Intra, see
    /// https://ieeexplore.ieee.org/document/7290936. For information about 4K/2K in
    /// AVC-Intra, see
    /// https://pro-av.panasonic.net/en/avc-ultra/AVC-ULTRAoverview.pdf.
    avc_intra_settings: ?AvcIntraSettings,

    /// Specifies the video codec. This must be equal to one of the enum values
    /// defined by the object VideoCodec. To passthrough the video stream of your
    /// input without any video encoding: Choose Passthrough. More information about
    /// passthrough codec support and job settings requirements, see:
    /// https://docs.aws.amazon.com/mediaconvert/latest/ug/video-passthrough-feature-restrictions.html
    codec: ?VideoCodec,

    /// Required when you set Codec to the value FRAME_CAPTURE.
    frame_capture_settings: ?FrameCaptureSettings,

    /// Required when you set (Codec) under (VideoDescription)>(CodecSettings) to
    /// the value GIF
    gif_settings: ?GifSettings,

    /// Required when you set Codec to the value H_264.
    h264_settings: ?H264Settings,

    /// Settings for H265 codec
    h265_settings: ?H265Settings,

    /// Required when you set Codec to the value MPEG2.
    mpeg_2_settings: ?Mpeg2Settings,

    /// Optional settings when you set Codec to the value Passthrough.
    passthrough_settings: ?PassthroughSettings,

    /// Required when you set Codec to the value PRORES.
    prores_settings: ?ProresSettings,

    /// Required when you set Codec, under VideoDescription>CodecSettings to the
    /// value UNCOMPRESSED.
    uncompressed_settings: ?UncompressedSettings,

    /// Required when you set Codec to the value VC3
    vc_3_settings: ?Vc3Settings,

    /// Required when you set Codec to the value VP8.
    vp_8_settings: ?Vp8Settings,

    /// Required when you set Codec to the value VP9.
    vp_9_settings: ?Vp9Settings,

    /// Required when you set Codec to the value XAVC.
    xavc_settings: ?XavcSettings,

    pub const json_field_names = .{
        .av_1_settings = "Av1Settings",
        .avc_intra_settings = "AvcIntraSettings",
        .codec = "Codec",
        .frame_capture_settings = "FrameCaptureSettings",
        .gif_settings = "GifSettings",
        .h264_settings = "H264Settings",
        .h265_settings = "H265Settings",
        .mpeg_2_settings = "Mpeg2Settings",
        .passthrough_settings = "PassthroughSettings",
        .prores_settings = "ProresSettings",
        .uncompressed_settings = "UncompressedSettings",
        .vc_3_settings = "Vc3Settings",
        .vp_8_settings = "Vp8Settings",
        .vp_9_settings = "Vp9Settings",
        .xavc_settings = "XavcSettings",
    };
};
