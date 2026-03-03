const AllowedRenditionSize = @import("allowed_rendition_size.zig").AllowedRenditionSize;
const ForceIncludeRenditionSize = @import("force_include_rendition_size.zig").ForceIncludeRenditionSize;
const MinBottomRenditionSize = @import("min_bottom_rendition_size.zig").MinBottomRenditionSize;
const MinTopRenditionSize = @import("min_top_rendition_size.zig").MinTopRenditionSize;
const RuleType = @import("rule_type.zig").RuleType;

/// Specify one or more Automated ABR rule types. Note: Force include and
/// Allowed renditions are mutually exclusive.
pub const AutomatedAbrRule = struct {
    /// When customer adds the allowed renditions rule for auto ABR ladder, they are
    /// required to add at leat one rendition to allowedRenditions list
    allowed_renditions: ?[]const AllowedRenditionSize = null,

    /// When customer adds the force include renditions rule for auto ABR ladder,
    /// they are required to add at leat one rendition to forceIncludeRenditions
    /// list
    force_include_renditions: ?[]const ForceIncludeRenditionSize = null,

    /// Use Min bottom rendition size to specify a minimum size for the lowest
    /// resolution in your ABR stack. * The lowest resolution in your ABR stack will
    /// be equal to or greater than the value that you enter. For example: If you
    /// specify 640x360 the lowest resolution in your ABR stack will be equal to or
    /// greater than to 640x360. * If you specify a Min top rendition size rule, the
    /// value that you specify for Min bottom rendition size must be less than, or
    /// equal to, Min top rendition size.
    min_bottom_rendition_size: ?MinBottomRenditionSize = null,

    /// Use Min top rendition size to specify a minimum size for the highest
    /// resolution in your ABR stack. * The highest resolution in your ABR stack
    /// will be equal to or greater than the value that you enter. For example: If
    /// you specify 1280x720 the highest resolution in your ABR stack will be equal
    /// to or greater than 1280x720. * If you specify a value for Max resolution,
    /// the value that you specify for Min top rendition size must be less than, or
    /// equal to, Max resolution.
    min_top_rendition_size: ?MinTopRenditionSize = null,

    /// Use Min top rendition size to specify a minimum size for the highest
    /// resolution in your ABR stack. * The highest resolution in your ABR stack
    /// will be equal to or greater than the value that you enter. For example: If
    /// you specify 1280x720 the highest resolution in your ABR stack will be equal
    /// to or greater than 1280x720. * If you specify a value for Max resolution,
    /// the value that you specify for Min top rendition size must be less than, or
    /// equal to, Max resolution. Use Min bottom rendition size to specify a minimum
    /// size for the lowest resolution in your ABR stack. * The lowest resolution in
    /// your ABR stack will be equal to or greater than the value that you enter.
    /// For example: If you specify 640x360 the lowest resolution in your ABR stack
    /// will be equal to or greater than to 640x360. * If you specify a Min top
    /// rendition size rule, the value that you specify for Min bottom rendition
    /// size must be less than, or equal to, Min top rendition size. Use Force
    /// include renditions to specify one or more resolutions to include your ABR
    /// stack. * (Recommended) To optimize automated ABR, specify as few resolutions
    /// as possible. * (Required) The number of resolutions that you specify must be
    /// equal to, or less than, the Max renditions setting. * If you specify a Min
    /// top rendition size rule, specify at least one resolution that is equal to,
    /// or greater than, Min top rendition size. * If you specify a Min bottom
    /// rendition size rule, only specify resolutions that are equal to, or greater
    /// than, Min bottom rendition size. * If you specify a Force include renditions
    /// rule, do not specify a separate rule for Allowed renditions. * Note: The ABR
    /// stack may include other resolutions that you do not specify here, depending
    /// on the Max renditions setting. Use Allowed renditions to specify a list of
    /// possible resolutions in your ABR stack. * (Required) The number of
    /// resolutions that you specify must be equal to, or greater than, the Max
    /// renditions setting. * MediaConvert will create an ABR stack exclusively from
    /// the list of resolutions that you specify. * Some resolutions in the Allowed
    /// renditions list may not be included, however you can force a resolution to
    /// be included by setting Required to ENABLED. * You must specify at least one
    /// resolution that is greater than or equal to any resolutions that you specify
    /// in Min top rendition size or Min bottom rendition size. * If you specify
    /// Allowed renditions, you must not specify a separate rule for Force include
    /// renditions.
    @"type": ?RuleType = null,

    pub const json_field_names = .{
        .allowed_renditions = "AllowedRenditions",
        .force_include_renditions = "ForceIncludeRenditions",
        .min_bottom_rendition_size = "MinBottomRenditionSize",
        .min_top_rendition_size = "MinTopRenditionSize",
        .@"type" = "Type",
    };
};
