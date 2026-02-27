const VideoOverlayCrop = @import("video_overlay_crop.zig").VideoOverlayCrop;
const VideoOverlayPosition = @import("video_overlay_position.zig").VideoOverlayPosition;
const VideoOverlayInput = @import("video_overlay_input.zig").VideoOverlayInput;
const VideoOverlayPlayBackMode = @import("video_overlay_play_back_mode.zig").VideoOverlayPlayBackMode;
const VideoOverlayTransition = @import("video_overlay_transition.zig").VideoOverlayTransition;

/// Overlay one or more videos on top of your input video. For more information,
/// see https://docs.aws.amazon.com/mediaconvert/latest/ug/video-overlays.html
pub const VideoOverlay = struct {
    /// Specify a rectangle of content to crop and use from your video overlay's
    /// input video. When you do, MediaConvert uses the cropped dimensions that you
    /// specify under X offset, Y offset, Width, and Height.
    crop: ?VideoOverlayCrop,

    /// Enter the end timecode in the base input video for this overlay. Your
    /// overlay will be active through this frame. To display your video overlay for
    /// the duration of the base input video: Leave blank. Use the format
    /// HH:MM:SS:FF or HH:MM:SS;FF, where HH is the hour, MM is the minute, SS isthe
    /// second, and FF is the frame number. When entering this value, take into
    /// account your choice for the base input video's timecode source. For example,
    /// if you have embedded timecodes that start at 01:00:00:00 and you want your
    /// overlay to end ten minutes into the video, enter 01:10:00:00.
    end_timecode: ?[]const u8,

    /// Specify the Initial position of your video overlay. To specify the Initial
    /// position of your video overlay, including distance from the left or top edge
    /// of the base input video's frame, or size: Enter a value for X position, Y
    /// position, Width, or Height. To use the full frame of the base input video:
    /// Leave blank.
    initial_position: ?VideoOverlayPosition,

    /// Input settings for Video overlay. You can include one or more video overlays
    /// in sequence at different times that you specify.
    input: ?VideoOverlayInput,

    /// Specify whether your video overlay repeats or plays only once. To repeat
    /// your video overlay on a loop: Keep the default value, Repeat. Your overlay
    /// will repeat for the duration of the base input video. To playback your video
    /// overlay only once: Choose Once. With either option, you can end playback at
    /// a time that you specify by entering a value for End timecode.
    playback: ?VideoOverlayPlayBackMode,

    /// Enter the start timecode in the base input video for this overlay. Your
    /// overlay will be active starting with this frame. To display your video
    /// overlay starting at the beginning of the base input video: Leave blank. Use
    /// the format HH:MM:SS:FF or HH:MM:SS;FF, where HH is the hour, MM is the
    /// minute, SS is the second, and FF is the frame number. When entering this
    /// value, take into account your choice for the base input video's timecode
    /// source. For example, if you have embedded timecodes that start at
    /// 01:00:00:00 and you want your overlay to begin five minutes into the video,
    /// enter 01:05:00:00.
    start_timecode: ?[]const u8,

    /// Specify one or more transitions for your video overlay. Use Transitions to
    /// reposition or resize your overlay over time. To use the same position and
    /// size for the duration of your video overlay: Leave blank. To specify a
    /// Transition: Enter a value for Start timecode, End Timecode, X Position, Y
    /// Position, Width, or Height.
    transitions: ?[]const VideoOverlayTransition,

    pub const json_field_names = .{
        .crop = "Crop",
        .end_timecode = "EndTimecode",
        .initial_position = "InitialPosition",
        .input = "Input",
        .playback = "Playback",
        .start_timecode = "StartTimecode",
        .transitions = "Transitions",
    };
};
