const BurninSubtitleAlignment = @import("burnin_subtitle_alignment.zig").BurninSubtitleAlignment;
const BurninSubtitleApplyFontColor = @import("burnin_subtitle_apply_font_color.zig").BurninSubtitleApplyFontColor;
const BurninSubtitleBackgroundColor = @import("burnin_subtitle_background_color.zig").BurninSubtitleBackgroundColor;
const BurninSubtitleFallbackFont = @import("burnin_subtitle_fallback_font.zig").BurninSubtitleFallbackFont;
const BurninSubtitleFontColor = @import("burnin_subtitle_font_color.zig").BurninSubtitleFontColor;
const FontScript = @import("font_script.zig").FontScript;
const BurninSubtitleOutlineColor = @import("burnin_subtitle_outline_color.zig").BurninSubtitleOutlineColor;
const RemoveRubyReserveAttributes = @import("remove_ruby_reserve_attributes.zig").RemoveRubyReserveAttributes;
const BurninSubtitleShadowColor = @import("burnin_subtitle_shadow_color.zig").BurninSubtitleShadowColor;
const BurnInSubtitleStylePassthrough = @import("burn_in_subtitle_style_passthrough.zig").BurnInSubtitleStylePassthrough;
const BurninSubtitleTeletextSpacing = @import("burnin_subtitle_teletext_spacing.zig").BurninSubtitleTeletextSpacing;

/// Burn-in is a captions delivery method, rather than a captions format.
/// Burn-in writes the captions directly on your video frames, replacing pixels
/// of video content with the captions. Set up burn-in captions in the same
/// output as your video. For more information, see
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/burn-in-output-captions.html.
pub const BurninDestinationSettings = struct {
    /// Specify the alignment of your captions. If no explicit x_position is
    /// provided, setting alignment to centered will placethe captions at the bottom
    /// center of the output. Similarly, setting a left alignment willalign captions
    /// to the bottom left of the output. If x and y positions are given in
    /// conjunction with the alignment parameter, the font will be justified (either
    /// left or centered) relative to those coordinates.
    alignment: ?BurninSubtitleAlignment = null,

    /// Ignore this setting unless Style passthrough is set to Enabled and Font
    /// color set to Black, Yellow, Red, Green, Blue, or Hex. Use Apply font color
    /// for additional font color controls. When you choose White text only, or
    /// leave blank, your font color setting only applies to white text in your
    /// input captions. For example, if your font color setting is Yellow, and your
    /// input captions have red and white text, your output captions will have red
    /// and yellow text. When you choose ALL_TEXT, your font color setting applies
    /// to all of your output captions text.
    apply_font_color: ?BurninSubtitleApplyFontColor = null,

    /// Specify the color of the rectangle behind the captions. Leave background
    /// color blank and set Style passthrough to enabled to use the background color
    /// data from your input captions, if present.
    background_color: ?BurninSubtitleBackgroundColor = null,

    /// Specify the opacity of the background rectangle. Enter a value from 0 to
    /// 255, where 0 is transparent and 255 is opaque. If Style passthrough is set
    /// to enabled, leave blank to pass through the background style information in
    /// your input captions to your output captions. If Style passthrough is set to
    /// disabled, leave blank to use a value of 0 and remove all backgrounds from
    /// your output captions.
    background_opacity: ?i32 = null,

    /// Specify the font that you want the service to use for your burn in captions
    /// when your input captions specify a font that MediaConvert doesn't support.
    /// When you set Fallback font to best match, or leave blank, MediaConvert uses
    /// a supported font that most closely matches the font that your input captions
    /// specify. When there are multiple unsupported fonts in your input captions,
    /// MediaConvert matches each font with the supported font that matches best.
    /// When you explicitly choose a replacement font, MediaConvert uses that font
    /// to replace all unsupported fonts from your input.
    fallback_font: ?BurninSubtitleFallbackFont = null,

    /// Specify the color of the burned-in captions text. Leave Font color blank and
    /// set Style passthrough to enabled to use the font color data from your input
    /// captions, if present.
    font_color: ?BurninSubtitleFontColor = null,

    /// Specify a bold TrueType font file to use when rendering your output
    /// captions. Enter an S3, HTTP, or HTTPS URL. When you do, you must also
    /// separately specify a regular, an italic, and a bold italic font file.
    font_file_bold: ?[]const u8 = null,

    /// Specify a bold italic TrueType font file to use when rendering your output
    /// captions.
    /// Enter an S3, HTTP, or HTTPS URL.
    /// When you do, you must also separately specify a regular, a bold, and an
    /// italic font file.
    font_file_bold_italic: ?[]const u8 = null,

    /// Specify an italic TrueType font file to use when rendering your output
    /// captions. Enter an S3, HTTP, or HTTPS URL. When you do, you must also
    /// separately specify a regular, a bold, and a bold italic font file.
    font_file_italic: ?[]const u8 = null,

    /// Specify a regular TrueType font file to use when rendering your output
    /// captions. Enter an S3, HTTP, or HTTPS URL. When you do, you must also
    /// separately specify a bold, an italic, and a bold italic font file.
    font_file_regular: ?[]const u8 = null,

    /// Specify the opacity of the burned-in captions. 255 is opaque; 0 is
    /// transparent.
    font_opacity: ?i32 = null,

    /// Specify the Font resolution in DPI (dots per inch).
    font_resolution: ?i32 = null,

    /// Set Font script to Automatically determined, or leave blank, to
    /// automatically determine the font script in your input captions. Otherwise,
    /// set to Simplified Chinese (HANS) or Traditional Chinese (HANT) if your input
    /// font script uses Simplified or Traditional Chinese.
    font_script: ?FontScript = null,

    /// Specify the Font size in pixels. Must be a positive integer. Set to 0, or
    /// leave blank, for automatic font size.
    font_size: ?i32 = null,

    /// Ignore this setting unless your Font color is set to Hex. Enter either six
    /// or eight hexidecimal digits, representing red, green, and blue, with two
    /// optional extra digits for alpha. For example a value of 1122AABB is a red
    /// value of 0x11, a green value of 0x22, a blue value of 0xAA, and an alpha
    /// value of 0xBB.
    hex_font_color: ?[]const u8 = null,

    /// Specify font outline color. Leave Outline color blank and set Style
    /// passthrough to enabled to use the font outline color data from your input
    /// captions, if present.
    outline_color: ?BurninSubtitleOutlineColor = null,

    /// Specify the Outline size of the caption text, in pixels. Leave Outline size
    /// blank and set Style passthrough to enabled to use the outline size data from
    /// your input captions, if present.
    outline_size: ?i32 = null,

    /// Optionally remove any tts:rubyReserve attributes present in your input, that
    /// do not have a tts:ruby attribute in the same element, from your output. Use
    /// if your vertical Japanese output captions have alignment issues. To remove
    /// ruby reserve attributes when present: Choose Enabled. To not remove any ruby
    /// reserve attributes: Keep the default value, Disabled.
    remove_ruby_reserve_attributes: ?RemoveRubyReserveAttributes = null,

    /// Specify the color of the shadow cast by the captions. Leave Shadow color
    /// blank and set Style passthrough to enabled to use the shadow color data from
    /// your input captions, if present.
    shadow_color: ?BurninSubtitleShadowColor = null,

    /// Specify the opacity of the shadow. Enter a value from 0 to 255, where 0 is
    /// transparent and 255 is opaque. If Style passthrough is set to Enabled, leave
    /// Shadow opacity blank to pass through the shadow style information in your
    /// input captions to your output captions. If Style passthrough is set to
    /// disabled, leave blank to use a value of 0 and remove all shadows from your
    /// output captions.
    shadow_opacity: ?i32 = null,

    /// Specify the horizontal offset of the shadow, relative to the captions in
    /// pixels. A value of -2 would result in a shadow offset 2 pixels to the left.
    shadow_x_offset: ?i32 = null,

    /// Specify the vertical offset of the shadow relative to the captions in
    /// pixels. A value of -2 would result in a shadow offset 2 pixels above the
    /// text. Leave Shadow y-offset blank and set Style passthrough to enabled to
    /// use the shadow y-offset data from your input captions, if present.
    shadow_y_offset: ?i32 = null,

    /// To use the available style, color, and position information from your input
    /// captions: Set Style passthrough to Enabled. Note that MediaConvert uses
    /// default settings for any missing style or position information in your input
    /// captions To ignore the style and position information from your input
    /// captions and use default settings: Leave blank or keep the default value,
    /// Disabled. Default settings include white text with black outlining,
    /// bottom-center positioning, and automatic sizing. Whether you set Style
    /// passthrough to enabled or not, you can also choose to manually override any
    /// of the individual style and position settings. You can also override any
    /// fonts by manually specifying custom font files.
    style_passthrough: ?BurnInSubtitleStylePassthrough = null,

    /// Specify whether the text spacing in your captions is set by the captions
    /// grid, or varies depending on letter width. Choose fixed grid to conform to
    /// the spacing specified in the captions file more accurately. Choose
    /// proportional to make the text easier to read for closed captions.
    teletext_spacing: ?BurninSubtitleTeletextSpacing = null,

    /// Specify the horizontal position of the captions, relative to the left side
    /// of the output in pixels. A value of 10 would result in the captions starting
    /// 10 pixels from the left of the output. If no explicit x_position is
    /// provided, the horizontal caption position will be determined by the
    /// alignment parameter.
    x_position: ?i32 = null,

    /// Specify the vertical position of the captions, relative to the top of the
    /// output in pixels. A value of 10 would result in the captions starting 10
    /// pixels from the top of the output. If no explicit y_position is provided,
    /// the caption will be positioned towards the bottom of the output.
    y_position: ?i32 = null,

    pub const json_field_names = .{
        .alignment = "Alignment",
        .apply_font_color = "ApplyFontColor",
        .background_color = "BackgroundColor",
        .background_opacity = "BackgroundOpacity",
        .fallback_font = "FallbackFont",
        .font_color = "FontColor",
        .font_file_bold = "FontFileBold",
        .font_file_bold_italic = "FontFileBoldItalic",
        .font_file_italic = "FontFileItalic",
        .font_file_regular = "FontFileRegular",
        .font_opacity = "FontOpacity",
        .font_resolution = "FontResolution",
        .font_script = "FontScript",
        .font_size = "FontSize",
        .hex_font_color = "HexFontColor",
        .outline_color = "OutlineColor",
        .outline_size = "OutlineSize",
        .remove_ruby_reserve_attributes = "RemoveRubyReserveAttributes",
        .shadow_color = "ShadowColor",
        .shadow_opacity = "ShadowOpacity",
        .shadow_x_offset = "ShadowXOffset",
        .shadow_y_offset = "ShadowYOffset",
        .style_passthrough = "StylePassthrough",
        .teletext_spacing = "TeletextSpacing",
        .x_position = "XPosition",
        .y_position = "YPosition",
    };
};
