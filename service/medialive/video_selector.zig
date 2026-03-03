const VideoSelectorColorSpace = @import("video_selector_color_space.zig").VideoSelectorColorSpace;
const VideoSelectorColorSpaceSettings = @import("video_selector_color_space_settings.zig").VideoSelectorColorSpaceSettings;
const VideoSelectorColorSpaceUsage = @import("video_selector_color_space_usage.zig").VideoSelectorColorSpaceUsage;
const VideoSelectorSettings = @import("video_selector_settings.zig").VideoSelectorSettings;

/// Specifies a particular video stream within an input source. An input may
/// have only a single video selector.
pub const VideoSelector = struct {
    /// Controls how MediaLive will use the color space metadata from the source.
    /// Typically, choose FOLLOW, which means to use the color space metadata
    /// without changing it. Or choose another value (a standard). In this case, the
    /// handling is controlled by the colorspaceUsage property.
    color_space: ?VideoSelectorColorSpace = null,

    /// Choose HDR10 only if the following situation applies. Firstly, you specified
    /// HDR10 in ColorSpace. Secondly, the attached input is for AWS Elemental Link.
    /// Thirdly, you plan to convert the content to another color space. You need to
    /// specify the color space metadata that is missing from the source sent from
    /// AWS Elemental Link.
    color_space_settings: ?VideoSelectorColorSpaceSettings = null,

    /// Applies only if colorSpace is a value other than follow. This field controls
    /// how the value in the colorSpace field will be used. fallback means that when
    /// the input does include color space data, that data will be used, but when
    /// the input has no color space data, the value in colorSpace will be used.
    /// Choose fallback if your input is sometimes missing color space data, but
    /// when it does have color space data, that data is correct. force means to
    /// always use the value in colorSpace. Choose force if your input usually has
    /// no color space data or might have unreliable color space data.
    color_space_usage: ?VideoSelectorColorSpaceUsage = null,

    /// The video selector settings.
    selector_settings: ?VideoSelectorSettings = null,

    pub const json_field_names = .{
        .color_space = "ColorSpace",
        .color_space_settings = "ColorSpaceSettings",
        .color_space_usage = "ColorSpaceUsage",
        .selector_settings = "SelectorSettings",
    };
};
