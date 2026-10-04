const FrameControl = @import("frame_control.zig").FrameControl;
const PassthroughSegmentationMode = @import("passthrough_segmentation_mode.zig").PassthroughSegmentationMode;
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

    /// Specify how many input GOPs MediaConvert places in each output segment when
    /// you set Passthrough segmentation mode to GOP count. For example, if your
    /// input has a closed GOP every 1.92 seconds and you specify 2, each output
    /// segment is 3.84 seconds. In this mode, output segment duration is determined
    /// by your input GOP structure rather than by your configured Segment length or
    /// Fragment length, so segment durations are consistent only when your input
    /// GOP cadence is constant. Segments at input discontinuities or ad avails may
    /// contain fewer GOPs.
    gops_per_segment: ?i32 = null,

    /// Choose how MediaConvert determines segment boundaries when you passthrough
    /// video to a segmented ABR output (HLS, DASH, or CMAF). This setting applies
    /// only to ABR outputs. Keep the default value, Auto, to let MediaConvert
    /// choose based on your input: when your input is a segmented HLS or DASH
    /// source, MediaConvert reproduces your input's own segment boundaries, with
    /// one output segment per input segment; for all other inputs, MediaConvert
    /// places boundaries by duration, cutting at the first eligible IDR-frame at or
    /// after each configured Segment length or Fragment length target. Choose
    /// Duration based to always place boundaries by duration, at the first eligible
    /// IDR-frame at or after each configured Segment length or Fragment length
    /// target, regardless of your input. When your input GOP duration does not
    /// evenly divide your target segment length, output segment durations will
    /// vary. Choose GOP count to place a fixed number of input GOPs in every
    /// segment, and specify GOPs per segment. Every segment contains the same
    /// number of input GOPs, which produces consistent segment durations when your
    /// input GOP cadence is constant. In this mode MediaConvert ignores your
    /// configured Segment length and Fragment length for video boundary placement.
    /// Ad avails and input discontinuities are still honored as segment boundaries.
    segmentation_mode: ?PassthroughSegmentationMode = null,

    /// AUTO will select the highest bitrate input in the video selector source.
    /// REMUX_ALL will passthrough all the selected streams in the video selector
    /// source. When selecting streams from multiple renditions (i.e. using Stream
    /// video selector type): REMUX_ALL will only remux all streams selected, and
    /// AUTO will use the highest bitrate video stream among the selected streams as
    /// source.
    video_selector_mode: ?VideoSelectorMode = null,

    pub const json_field_names = .{
        .frame_control = "FrameControl",
        .gops_per_segment = "GopsPerSegment",
        .segmentation_mode = "SegmentationMode",
        .video_selector_mode = "VideoSelectorMode",
    };
};
