/// Represents the screen resolution of a device in height and width, expressed
/// in
/// pixels.
pub const Resolution = struct {
    /// The screen resolution's height, expressed in pixels.
    height: ?i32 = null,

    /// The screen resolution's width, expressed in pixels.
    width: ?i32 = null,

    pub const json_field_names = .{
        .height = "height",
        .width = "width",
    };
};
