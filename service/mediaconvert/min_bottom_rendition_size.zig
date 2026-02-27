/// Use Min bottom rendition size to specify a minimum size for the lowest
/// resolution in your ABR stack. * The lowest resolution in your ABR stack will
/// be equal to or greater than the value that you enter. For example: If you
/// specify 640x360 the lowest resolution in your ABR stack will be equal to or
/// greater than to 640x360. * If you specify a Min top rendition size rule, the
/// value that you specify for Min bottom rendition size must be less than, or
/// equal to, Min top rendition size.
pub const MinBottomRenditionSize = struct {
    /// Use Height to define the video resolution height, in pixels, for this rule.
    height: ?i32,

    /// Use Width to define the video resolution width, in pixels, for this rule.
    width: ?i32,

    pub const json_field_names = .{
        .height = "Height",
        .width = "Width",
    };
};
