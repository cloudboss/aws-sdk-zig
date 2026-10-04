/// Contains the width and height dimensions, in pixels, that define the
/// resolution of the stream session's virtual monitor. The total number of
/// pixels (width × height) must not exceed 2,073,600 (equivalent to 1920 ×
/// 1080).
pub const Resolution = struct {
    /// The height of the stream session's virtual monitor, in pixels. The value
    /// must be an even number.
    height: i32,

    /// The width of the stream session's virtual monitor, in pixels. The value must
    /// be an even number.
    width: i32,

    pub const json_field_names = .{
        .height = "Height",
        .width = "Width",
    };
};
