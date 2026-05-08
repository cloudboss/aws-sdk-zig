const FontConfiguration = @import("font_configuration.zig").FontConfiguration;
const HorizontalTextAlignment = @import("horizontal_text_alignment.zig").HorizontalTextAlignment;

/// Configures the display properties of the control title.
pub const ControlTitleFontConfiguration = struct {
    /// Configures the font settings for the control title.
    font_configuration: ?FontConfiguration = null,

    /// Determines the alignment of the control title.
    text_alignment: ?HorizontalTextAlignment = null,

    pub const json_field_names = .{
        .font_configuration = "FontConfiguration",
        .text_alignment = "TextAlignment",
    };
};
