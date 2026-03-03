const DvbSubtitleAlignment = @import("dvb_subtitle_alignment.zig").DvbSubtitleAlignment;
const DvbSubtitleApplyFontColor = @import("dvb_subtitle_apply_font_color.zig").DvbSubtitleApplyFontColor;
const DvbSubtitleBackgroundColor = @import("dvb_subtitle_background_color.zig").DvbSubtitleBackgroundColor;
const DvbddsHandling = @import("dvbdds_handling.zig").DvbddsHandling;
const DvbSubSubtitleFallbackFont = @import("dvb_sub_subtitle_fallback_font.zig").DvbSubSubtitleFallbackFont;
const DvbSubtitleFontColor = @import("dvb_subtitle_font_color.zig").DvbSubtitleFontColor;
const FontScript = @import("font_script.zig").FontScript;
const DvbSubtitleOutlineColor = @import("dvb_subtitle_outline_color.zig").DvbSubtitleOutlineColor;
const DvbSubtitleShadowColor = @import("dvb_subtitle_shadow_color.zig").DvbSubtitleShadowColor;
const DvbSubtitleStylePassthrough = @import("dvb_subtitle_style_passthrough.zig").DvbSubtitleStylePassthrough;
const DvbSubtitlingType = @import("dvb_subtitling_type.zig").DvbSubtitlingType;
const DvbSubtitleTeletextSpacing = @import("dvb_subtitle_teletext_spacing.zig").DvbSubtitleTeletextSpacing;

/// Settings related to DVB-Sub captions. Set up DVB-Sub captions in the same
/// output as your video. For more information, see
/// https://docs.aws.amazon.com/mediaconvert/latest/ug/dvb-sub-output-captions.html.
pub const DvbSubDestinationSettings = struct {
    /// Specify the alignment of your captions. If no explicit x_position is
    /// provided, setting alignment to centered will placethe captions at the bottom
    /// center of the output. Similarly, setting a left alignment willalign captions
    /// to the bottom left of the output. If x and y positions are given in
    /// conjunction with the alignment parameter, the font will be justified (either
    /// left or centered) relative to those coordinates. Within your job settings,
    /// all of your DVB-Sub settings must be identical.
    alignment: ?DvbSubtitleAlignment = null,

    /// Ignore this setting unless Style Passthrough is set to Enabled and Font
    /// color set to Black, Yellow, Red, Green, Blue, or Hex. Use Apply font color
    /// for additional font color controls. When you choose White text only, or
    /// leave blank, your font color setting only applies to white text in your
    /// input captions. For example, if your font color setting is Yellow, and your
    /// input captions have red and white text, your output captions will have red
    /// and yellow text. When you choose ALL_TEXT, your font color setting applies
    /// to all of your output captions text.
    apply_font_color: ?DvbSubtitleApplyFontColor = null,

    /// Specify the color of the rectangle behind the captions. Leave background
    /// color blank and set Style passthrough to enabled to use the background color
    /// data from your input captions, if present.
    background_color: ?DvbSubtitleBackgroundColor = null,

    /// Specify the opacity of the background rectangle. Enter a value from 0 to
    /// 255, where 0 is transparent and 255 is opaque. If Style passthrough is set
    /// to enabled, leave blank to pass through the background style information in
    /// your input captions to your output captions. If Style passthrough is set to
    /// disabled, leave blank to use a value of 0 and remove all backgrounds from
    /// your output captions. Within your job settings, all of your DVB-Sub settings
    /// must be identical.
    background_opacity: ?i32 = null,

    /// Specify how MediaConvert handles the display definition segment (DDS). To
    /// exclude the DDS from this set of captions: Keep the default, None. To
    /// include the DDS: Choose Specified. When you do, also specify the offset
    /// coordinates of the display window with DDS x-coordinate and DDS
    /// y-coordinate. To include the DDS, but not include display window data:
    /// Choose No display window. When you do, you can write position metadata to
    /// the page composition segment (PCS) with DDS x-coordinate and DDS
    /// y-coordinate. For video resolutions with a height of 576 pixels or less,
    /// MediaConvert doesn't include the DDS, regardless of the value you choose for
    /// DDS handling. All burn-in and DVB-Sub font settings must match. To include
    /// the DDS, with optimized subtitle placement and reduced data overhead: We
    /// recommend that you choose Specified (optimal). This option provides the same
    /// visual positioning as Specified while using less bandwidth. This also
    /// supports resolutions higher than 1080p while maintaining full DVB-Sub
    /// compatibility. When you do, also specify the offset coordinates of the
    /// display window with DDS x-coordinate and DDS y-coordinate.
    dds_handling: ?DvbddsHandling = null,

    /// Use this setting, along with DDS y-coordinate, to specify the upper left
    /// corner of the display definition segment (DDS) display window. With this
    /// setting, specify the distance, in pixels, between the left side of the frame
    /// and the left side of the DDS display window. Keep the default value, 0, to
    /// have MediaConvert automatically choose this offset. Related setting: When
    /// you use this setting, you must set DDS handling to a value other than None.
    /// MediaConvert uses these values to determine whether to write page position
    /// data to the DDS or to the page composition segment. All burn-in and DVB-Sub
    /// font settings must match.
    dds_x_coordinate: ?i32 = null,

    /// Use this setting, along with DDS x-coordinate, to specify the upper left
    /// corner of the display definition segment (DDS) display window. With this
    /// setting, specify the distance, in pixels, between the top of the frame and
    /// the top of the DDS display window. Keep the default value, 0, to have
    /// MediaConvert automatically choose this offset. Related setting: When you use
    /// this setting, you must set DDS handling to a value other than None.
    /// MediaConvert uses these values to determine whether to write page position
    /// data to the DDS or to the page composition segment (PCS). All burn-in and
    /// DVB-Sub font settings must match.
    dds_y_coordinate: ?i32 = null,

    /// Specify the font that you want the service to use for your burn in captions
    /// when your input captions specify a font that MediaConvert doesn't support.
    /// When you set Fallback font to best match, or leave blank, MediaConvert uses
    /// a supported font that most closely matches the font that your input captions
    /// specify. When there are multiple unsupported fonts in your input captions,
    /// MediaConvert matches each font with the supported font that matches best.
    /// When you explicitly choose a replacement font, MediaConvert uses that font
    /// to replace all unsupported fonts from your input.
    fallback_font: ?DvbSubSubtitleFallbackFont = null,

    /// Specify the color of the captions text. Leave Font color blank and set Style
    /// passthrough to enabled to use the font color data from your input captions,
    /// if present. Within your job settings, all of your DVB-Sub settings must be
    /// identical.
    font_color: ?DvbSubtitleFontColor = null,

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
    /// Within your job settings, all of your DVB-Sub settings must be identical.
    font_opacity: ?i32 = null,

    /// Specify the Font resolution in DPI (dots per inch).
    /// Within your job settings, all of your DVB-Sub settings must be identical.
    font_resolution: ?i32 = null,

    /// Set Font script to Automatically determined, or leave blank, to
    /// automatically determine the font script in your input captions. Otherwise,
    /// set to Simplified Chinese (HANS) or Traditional Chinese (HANT) if your input
    /// font script uses Simplified or Traditional Chinese. Within your job
    /// settings, all of your DVB-Sub settings must be identical.
    font_script: ?FontScript = null,

    /// Specify the Font size in pixels. Must be a positive integer. Set to 0, or
    /// leave blank, for automatic font size. Within your job settings, all of your
    /// DVB-Sub settings must be identical.
    font_size: ?i32 = null,

    /// Specify the height, in pixels, of this set of DVB-Sub captions. The default
    /// value is 576 pixels. Related setting: When you use this setting, you must
    /// set DDS handling to a value other than None. All burn-in and DVB-Sub font
    /// settings must match.
    height: ?i32 = null,

    /// Ignore this setting unless your Font color is set to Hex. Enter either six
    /// or eight hexidecimal digits, representing red, green, and blue, with two
    /// optional extra digits for alpha. For example a value of 1122AABB is a red
    /// value of 0x11, a green value of 0x22, a blue value of 0xAA, and an alpha
    /// value of 0xBB.
    hex_font_color: ?[]const u8 = null,

    /// Specify font outline color. Leave Outline color blank and set Style
    /// passthrough to enabled to use the font outline color data from your input
    /// captions, if present. Within your job settings, all of your DVB-Sub settings
    /// must be identical.
    outline_color: ?DvbSubtitleOutlineColor = null,

    /// Specify the Outline size of the caption text, in pixels. Leave Outline size
    /// blank and set Style passthrough to enabled to use the outline size data from
    /// your input captions, if present. Within your job settings, all of your
    /// DVB-Sub settings must be identical.
    outline_size: ?i32 = null,

    /// Specify the color of the shadow cast by the captions. Leave Shadow color
    /// blank and set Style passthrough to enabled to use the shadow color data from
    /// your input captions, if present. Within your job settings, all of your
    /// DVB-Sub settings must be identical.
    shadow_color: ?DvbSubtitleShadowColor = null,

    /// Specify the opacity of the shadow. Enter a value from 0 to 255, where 0 is
    /// transparent and 255 is opaque. If Style passthrough is set to Enabled, leave
    /// Shadow opacity blank to pass through the shadow style information in your
    /// input captions to your output captions. If Style passthrough is set to
    /// disabled, leave blank to use a value of 0 and remove all shadows from your
    /// output captions. Within your job settings, all of your DVB-Sub settings must
    /// be identical.
    shadow_opacity: ?i32 = null,

    /// Specify the horizontal offset of the shadow, relative to the captions in
    /// pixels. A value of -2 would result in a shadow offset 2 pixels to the left.
    /// Within your job settings, all of your DVB-Sub settings must be identical.
    shadow_x_offset: ?i32 = null,

    /// Specify the vertical offset of the shadow relative to the captions in
    /// pixels. A value of -2 would result in a shadow offset 2 pixels above the
    /// text. Leave Shadow y-offset blank and set Style passthrough to enabled to
    /// use the shadow y-offset data from your input captions, if present. Within
    /// your job settings, all of your DVB-Sub settings must be identical.
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
    style_passthrough: ?DvbSubtitleStylePassthrough = null,

    /// Specify whether your DVB subtitles are standard or for hearing impaired.
    /// Choose hearing impaired if your subtitles include audio descriptions and
    /// dialogue. Choose standard if your subtitles include only dialogue.
    subtitling_type: ?DvbSubtitlingType = null,

    /// Specify whether the Text spacing in your captions is set by the captions
    /// grid, or varies depending on letter width. Choose fixed grid to conform to
    /// the spacing specified in the captions file more accurately. Choose
    /// proportional to make the text easier to read for closed captions. Within
    /// your job settings, all of your DVB-Sub settings must be identical.
    teletext_spacing: ?DvbSubtitleTeletextSpacing = null,

    /// Specify the width, in pixels, of this set of DVB-Sub captions. The default
    /// value is 720 pixels. Related setting: When you use this setting, you must
    /// set DDS handling to a value other than None. All burn-in and DVB-Sub font
    /// settings must match.
    width: ?i32 = null,

    /// Specify the horizontal position of the captions, relative to the left side
    /// of the output in pixels. A value of 10 would result in the captions starting
    /// 10 pixels from the left of the output. If no explicit x_position is
    /// provided, the horizontal caption position will be determined by the
    /// alignment parameter. Within your job settings, all of your DVB-Sub settings
    /// must be identical.
    x_position: ?i32 = null,

    /// Specify the vertical position of the captions, relative to the top of the
    /// output in pixels. A value of 10 would result in the captions starting 10
    /// pixels from the top of the output. If no explicit y_position is provided,
    /// the caption will be positioned towards the bottom of the output. Within your
    /// job settings, all of your DVB-Sub settings must be identical.
    y_position: ?i32 = null,

    pub const json_field_names = .{
        .alignment = "Alignment",
        .apply_font_color = "ApplyFontColor",
        .background_color = "BackgroundColor",
        .background_opacity = "BackgroundOpacity",
        .dds_handling = "DdsHandling",
        .dds_x_coordinate = "DdsXCoordinate",
        .dds_y_coordinate = "DdsYCoordinate",
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
        .height = "Height",
        .hex_font_color = "HexFontColor",
        .outline_color = "OutlineColor",
        .outline_size = "OutlineSize",
        .shadow_color = "ShadowColor",
        .shadow_opacity = "ShadowOpacity",
        .shadow_x_offset = "ShadowXOffset",
        .shadow_y_offset = "ShadowYOffset",
        .style_passthrough = "StylePassthrough",
        .subtitling_type = "SubtitlingType",
        .teletext_spacing = "TeletextSpacing",
        .width = "Width",
        .x_position = "XPosition",
        .y_position = "YPosition",
    };
};
