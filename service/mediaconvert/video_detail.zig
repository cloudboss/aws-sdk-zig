/// Contains details about the output's video stream
pub const VideoDetail = struct {
    /// Height in pixels for the output
    height_in_px: ?i32,

    /// Width in pixels for the output
    width_in_px: ?i32,

    pub const json_field_names = .{
        .height_in_px = "HeightInPx",
        .width_in_px = "WidthInPx",
    };
};
