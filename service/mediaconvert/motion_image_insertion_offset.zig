/// Specify the offset between the upper-left corner of the video frame and the
/// top left corner of the overlay.
pub const MotionImageInsertionOffset = struct {
    /// Set the distance, in pixels, between the overlay and the left edge of the
    /// video frame.
    image_x: ?i32,

    /// Set the distance, in pixels, between the overlay and the top edge of the
    /// video frame.
    image_y: ?i32,

    pub const json_field_names = .{
        .image_x = "ImageX",
        .image_y = "ImageY",
    };
};
