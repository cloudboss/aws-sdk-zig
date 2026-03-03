const FrameControl = @import("frame_control.zig").FrameControl;
const VideoSelectorMode = @import("video_selector_mode.zig").VideoSelectorMode;

/// Optional settings when you set Codec to the value Passthrough.
pub const PassthroughSettings = struct {
    /// Choose how MediaConvert handles start and end times for input clipping with
    /// video passthrough. Your input video codec must be H.264 or H.265 to use
    /// IFRAME. To clip at the nearest IDR-frame: Choose Nearest IDR. If an
    /// IDR-frame is not found at the frame that you specify, MediaConvert uses the
    /// next compatible IDR-frame. Note that your output may be shorter than your
    /// input clip duration. To clip at the nearest I-frame: Choose Nearest I-frame.
    /// If an I-frame is not found at the frame that you specify, MediaConvert uses
    /// the next compatible I-frame. Note that your output may be shorter than your
    /// input clip duration. We only recommend this setting for special workflows,
    /// and when you choose this setting your output may not be compatible with most
    /// players.
    frame_control: ?FrameControl = null,

    /// AUTO will select the highest bitrate input in the video selector source.
    /// REMUX_ALL will passthrough all the selected streams in the video selector
    /// source. When selecting streams from multiple renditions (i.e. using Stream
    /// video selector type): REMUX_ALL will only remux all streams selected, and
    /// AUTO will use the highest bitrate video stream among the selected streams as
    /// source.
    video_selector_mode: ?VideoSelectorMode = null,

    pub const json_field_names = .{
        .frame_control = "FrameControl",
        .video_selector_mode = "VideoSelectorMode",
    };
};
