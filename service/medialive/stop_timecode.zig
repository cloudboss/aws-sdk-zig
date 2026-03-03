const LastFrameClippingBehavior = @import("last_frame_clipping_behavior.zig").LastFrameClippingBehavior;

/// Settings to identify the end of the clip.
pub const StopTimecode = struct {
    /// If you specify a StopTimecode in an input (in order to clip the file), you
    /// can specify if you want the clip to exclude (the default) or include the
    /// frame specified by the timecode.
    last_frame_clipping_behavior: ?LastFrameClippingBehavior = null,

    /// The timecode for the frame where you want to stop the clip. Optional; if not
    /// specified, the clip continues to the end of the file. Enter the timecode as
    /// HH:MM:SS:FF or HH:MM:SS;FF.
    timecode: ?[]const u8 = null,

    pub const json_field_names = .{
        .last_frame_clipping_behavior = "LastFrameClippingBehavior",
        .timecode = "Timecode",
    };
};
