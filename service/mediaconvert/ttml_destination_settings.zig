const TtmlBackgroundColor = @import("ttml_background_color.zig").TtmlBackgroundColor;
const TtmlFontColor = @import("ttml_font_color.zig").TtmlFontColor;
const TtmlFontStyle = @import("ttml_font_style.zig").TtmlFontStyle;
const TtmlFontWeight = @import("ttml_font_weight.zig").TtmlFontWeight;
const TtmlStylePassthrough = @import("ttml_style_passthrough.zig").TtmlStylePassthrough;
const TtmlTextDecoration = @import("ttml_text_decoration.zig").TtmlTextDecoration;

/// Settings related to TTML captions. TTML is a sidecar format that holds
/// captions in a file that is separate from the video container. Set up sidecar
/// captions in the same output group, but different output from your video. For
/// more information, see
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/ttml-and-webvtt-output-captions.html.
pub const TtmlDestinationSettings = struct {
    /// Specify the color of the rectangle behind the captions. If Style passthrough
    /// is set to enabled, leave blank or set to Auto to pass through the background
    /// color from your input captions. If Style passthrough is set to disabled,
    /// leave blank or set to Auto to use the default black.
    background_color: ?TtmlBackgroundColor = null,

    /// Specify the opacity of the background rectangle. Enter a value from 0 to
    /// 255, where 0 is transparent and 255 is opaque. If Style passthrough is set
    /// to enabled, leave blank to pass through the background style information in
    /// your input captions to your output captions. If Style passthrough is set to
    /// disabled and backgroundColor is set, leave blank to use a value of 255
    /// (opaque).
    background_opacity: ?i32 = null,

    /// Specify the color of the captions text. If Style passthrough is set to
    /// enabled, leave blank or set to Auto to pass through the font color from your
    /// input captions. If Style passthrough is set to disabled, leave blank or set
    /// to Auto to use the default white.
    font_color: ?TtmlFontColor = null,

    /// Specify the opacity of the captions. Enter a value from 0 to 255, where 0 is
    /// transparent and 255 is opaque. If Style passthrough is set to enabled, leave
    /// blank to pass through the font opacity information in your input captions to
    /// your output captions. If Style passthrough is set to disabled and fontColor
    /// is set, leave blank to use a value of 255 (opaque).
    font_opacity: ?i32 = null,

    /// Specify the Font size in pixels. Must be a positive integer. Set to 0, or
    /// leave blank, for automatic font size.
    font_size: ?i32 = null,

    /// Specify the font style of the caption text. If Style passthrough is set to
    /// enabled, leave blank to pass through the font style from your input
    /// captions. If Style passthrough is set to disabled, leave blank to use the
    /// default normal style.
    font_style: ?TtmlFontStyle = null,

    /// Specify the font weight of the caption text. If Style passthrough is set to
    /// enabled, leave blank to pass through the font weight from your input
    /// captions. If Style passthrough is set to disabled, leave blank to use the
    /// default normal weight.
    font_weight: ?TtmlFontWeight = null,

    /// Pass through style and position information from a TTML-like input source
    /// (TTML, IMSC, SMPTE-TT) to the TTML output.
    style_passthrough: ?TtmlStylePassthrough = null,

    /// Specify the text decoration of the caption text. If Style passthrough is set
    /// to enabled, leave blank to pass through the text decoration from your input
    /// captions. If Style passthrough is set to disabled, leave blank to use the
    /// default of none.
    text_decoration: ?TtmlTextDecoration = null,

    pub const json_field_names = .{
        .background_color = "BackgroundColor",
        .background_opacity = "BackgroundOpacity",
        .font_color = "FontColor",
        .font_opacity = "FontOpacity",
        .font_size = "FontSize",
        .font_style = "FontStyle",
        .font_weight = "FontWeight",
        .style_passthrough = "StylePassthrough",
        .text_decoration = "TextDecoration",
    };
};
