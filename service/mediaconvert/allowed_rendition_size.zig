const RequiredFlag = @import("required_flag.zig").RequiredFlag;

/// Use Allowed renditions to specify a list of possible resolutions in your ABR
/// stack. * MediaConvert will create an ABR stack exclusively from the list of
/// resolutions that you specify. * Some resolutions in the Allowed renditions
/// list may not be included, however you can force a resolution to be included
/// by setting Required to ENABLED. * You must specify at least one resolution
/// that is greater than or equal to any resolutions that you specify in Min top
/// rendition size or Min bottom rendition size. * If you specify Allowed
/// renditions, you must not specify a separate rule for Force include
/// renditions.
pub const AllowedRenditionSize = struct {
    /// Use Height to define the video resolution height, in pixels, for this rule.
    height: ?i32 = null,

    /// Set to ENABLED to force a rendition to be included.
    required: ?RequiredFlag = null,

    /// Use Width to define the video resolution width, in pixels, for this rule.
    width: ?i32 = null,

    pub const json_field_names = .{
        .height = "Height",
        .required = "Required",
        .width = "Width",
    };
};
