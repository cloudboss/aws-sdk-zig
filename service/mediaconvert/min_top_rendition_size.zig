/// Use Min top rendition size to specify a minimum size for the highest
/// resolution in your ABR stack. * The highest resolution in your ABR stack
/// will be equal to or greater than the value that you enter. For example: If
/// you specify 1280x720 the highest resolution in your ABR stack will be equal
/// to or greater than 1280x720. * If you specify a value for Max resolution,
/// the value that you specify for Min top rendition size must be less than, or
/// equal to, Max resolution.
pub const MinTopRenditionSize = struct {
    /// Use Height to define the video resolution height, in pixels, for this rule.
    height: ?i32,

    /// Use Width to define the video resolution width, in pixels, for this rule.
    width: ?i32,

    pub const json_field_names = .{
        .height = "Height",
        .width = "Width",
    };
};
