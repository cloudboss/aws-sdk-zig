const EbuTtDFillLineGapControl = @import("ebu_tt_d_fill_line_gap_control.zig").EbuTtDFillLineGapControl;
const EbuTtDDestinationStyleControl = @import("ebu_tt_d_destination_style_control.zig").EbuTtDDestinationStyleControl;

/// Ebu Tt DDestination Settings
pub const EbuTtDDestinationSettings = struct {
    /// Complete this field if you want to include the name of the copyright holder
    /// in the copyright tag in the captions metadata.
    copyright_holder: ?[]const u8 = null,

    /// Specifies the default font size as a percentage of the computed cell size.
    /// Valid only if the defaultLineHeight is also set. If you leave this field
    /// empty, the default font size is 80% of the cell size.
    default_font_size: ?i32 = null,

    /// Documentation update needed
    default_line_height: ?i32 = null,

    /// Specifies how to handle the gap between the lines (in multi-line captions).
    /// ENABLED: Fill with the captions background color (as specified in the input
    /// captions). DISABLED: Leave the gap unfilled
    fill_line_gap: ?EbuTtDFillLineGapControl = null,

    /// Specifies the font family to include in the font data attached to the EBU-TT
    /// captions. Valid only if style_control is set to include. (If style_control
    /// is set to exclude, the font family is always set to monospaced.) Enter a
    /// list of font families, as a comma-separated list of font names, in order of
    /// preference. The name can be a font family (such as Arial), or a generic font
    /// family (such as serif), or default (to let the downstream player choose the
    /// font). Or leave blank to set the family to monospace. Note that you can
    /// specify only the font family. All other style information (color, bold,
    /// position and so on) is copied from the input captions. The size is always
    /// set to 100% to allow the downstream player to choose the size.
    font_family: ?[]const u8 = null,

    /// Specifies the style information to include in the font data that is attached
    /// to the EBU-TT captions. INCLUDE: Take the style information from the source
    /// captions and include that information in the font data attached to the
    /// EBU-TT captions. This option is valid only if the source captions are
    /// Embedded or Teletext. EXCLUDE: Set the font family to monospaced. Do not
    /// include any other style information.
    style_control: ?EbuTtDDestinationStyleControl = null,

    pub const json_field_names = .{
        .copyright_holder = "CopyrightHolder",
        .default_font_size = "DefaultFontSize",
        .default_line_height = "DefaultLineHeight",
        .fill_line_gap = "FillLineGap",
        .font_family = "FontFamily",
        .style_control = "StyleControl",
    };
};
