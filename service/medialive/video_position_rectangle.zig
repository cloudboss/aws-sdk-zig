/// A rectangle defined by position (x, y) and dimensions (width, height) in
/// pixels.
/// Used for output positioning and input cropping.
pub const VideoPositionRectangle = struct {
    /// Height in pixels. Must be an even number.
    height: i32,

    /// Width in pixels. Must be an even number.
    width: i32,

    /// Left offset in pixels. Must be an even number.
    x: i32,

    /// Top offset in pixels. Must be an even number.
    y: i32,

    pub const json_field_names = .{
        .height = "Height",
        .width = "Width",
        .x = "X",
        .y = "Y",
    };
};
