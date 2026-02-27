/// The frame resolution used by the video stream.
pub const FrameResolution = struct {
    /// The number of pixels in the height of the video frame.
    frame_height: i32,

    /// The number of pixels in the width of the video frame.
    frame_width: i32,

    pub const json_field_names = .{
        .frame_height = "FrameHeight",
        .frame_width = "FrameWidth",
    };
};
