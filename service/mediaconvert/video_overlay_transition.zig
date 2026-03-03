const VideoOverlayPosition = @import("video_overlay_position.zig").VideoOverlayPosition;

/// Specify one or more Transitions for your video overlay. Use Transitions to
/// reposition or resize your overlay over time. To use the same position and
/// size for the duration of your video overlay: Leave blank. To specify a
/// Transition: Enter a value for Start timecode, End Timecode, X Position, Y
/// Position, Width, Height, or Opacity
pub const VideoOverlayTransition = struct {
    /// Specify the ending position for this transition, relative to the base input
    /// video's frame. Your video overlay will move smoothly to this position,
    /// beginning at this transition's Start timecode and ending at this
    /// transition's End timecode.
    end_position: ?VideoOverlayPosition = null,

    /// Specify the timecode for when this transition ends. Use the format
    /// HH:MM:SS:FF or HH:MM:SS;FF, where HH is the hour, MM is the minute, SS is
    /// the second, and FF is the frame number. When entering this value, take into
    /// account your choice for Timecode source.
    end_timecode: ?[]const u8 = null,

    /// Specify the timecode for when this transition begins. Use the format
    /// HH:MM:SS:FF or HH:MM:SS;FF, where HH is the hour, MM is the minute, SS is
    /// the second, and FF is the frame number. When entering this value, take into
    /// account your choice for Timecode source.
    start_timecode: ?[]const u8 = null,

    pub const json_field_names = .{
        .end_position = "EndPosition",
        .end_timecode = "EndTimecode",
        .start_timecode = "StartTimecode",
    };
};
