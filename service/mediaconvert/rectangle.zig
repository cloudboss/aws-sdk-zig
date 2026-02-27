/// Use Rectangle to identify a specific area of the video frame.
pub const Rectangle = struct {
    /// Height of rectangle in pixels. Specify only even numbers.
    height: ?i32,

    /// Width of rectangle in pixels. Specify only even numbers.
    width: ?i32,

    /// The distance, in pixels, between the rectangle and the left edge of the
    /// video frame. Specify only even numbers.
    x: ?i32,

    /// The distance, in pixels, between the rectangle and the top edge of the video
    /// frame. Specify only even numbers.
    y: ?i32,

    pub const json_field_names = .{
        .height = "Height",
        .width = "Width",
        .x = "X",
        .y = "Y",
    };
};
