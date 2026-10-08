/// The width and height of the output video. Used in SubtitlingConfig to
/// determine subtitle layout.
pub const AspectRatio = struct {
    /// The height component of the aspect ratio (for example, 9 in a 16:9 ratio).
    height: i32,

    /// The width component of the aspect ratio (for example, 16 in a 16:9 ratio).
    width: i32,

    pub const json_field_names = .{
        .height = "height",
        .width = "width",
    };
};
