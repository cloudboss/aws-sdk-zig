const Av1Settings = @import("av_1_settings.zig").Av1Settings;
const FrameCaptureSettings = @import("frame_capture_settings.zig").FrameCaptureSettings;
const H264Settings = @import("h264_settings.zig").H264Settings;
const H265Settings = @import("h265_settings.zig").H265Settings;
const Mpeg2Settings = @import("mpeg_2_settings.zig").Mpeg2Settings;

/// Video Codec Settings
pub const VideoCodecSettings = struct {
    av_1_settings: ?Av1Settings,

    frame_capture_settings: ?FrameCaptureSettings,

    h264_settings: ?H264Settings,

    h265_settings: ?H265Settings,

    mpeg_2_settings: ?Mpeg2Settings,

    pub const json_field_names = .{
        .av_1_settings = "Av1Settings",
        .frame_capture_settings = "FrameCaptureSettings",
        .h264_settings = "H264Settings",
        .h265_settings = "H265Settings",
        .mpeg_2_settings = "Mpeg2Settings",
    };
};
