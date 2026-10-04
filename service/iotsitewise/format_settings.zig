/// Contains the output format configuration for video processing.
pub const FormatSettings = struct {
    /// The target frame rate for the output.
    frames_per_second: ?i32 = null,

    /// The target height of the output, in pixels.
    height_in_pixels: ?i32 = null,

    /// The target width of the output, in pixels.
    width_in_pixels: ?i32 = null,

    pub const json_field_names = .{
        .frames_per_second = "framesPerSecond",
        .height_in_pixels = "heightInPixels",
        .width_in_pixels = "widthInPixels",
    };
};
