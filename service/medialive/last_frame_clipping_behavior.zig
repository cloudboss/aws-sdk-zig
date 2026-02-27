/// If you specify a StopTimecode in an input (in order to clip the file), you
/// can specify if you want the clip to exclude (the default) or include the
/// frame specified by the timecode.
pub const LastFrameClippingBehavior = enum {
    exclude_last_frame,
    include_last_frame,

    pub const json_field_names = .{
        .exclude_last_frame = "EXCLUDE_LAST_FRAME",
        .include_last_frame = "INCLUDE_LAST_FRAME",
    };
};
