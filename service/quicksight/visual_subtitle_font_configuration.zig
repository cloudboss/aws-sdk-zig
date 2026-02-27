const FontConfiguration = @import("font_configuration.zig").FontConfiguration;
const HorizontalTextAlignment = @import("horizontal_text_alignment.zig").HorizontalTextAlignment;
const TextTransform = @import("text_transform.zig").TextTransform;

/// Configures the display properties of the visual sub-title.
pub const VisualSubtitleFontConfiguration = struct {
    font_configuration: ?FontConfiguration,

    /// Determines the alignment of visual sub-title.
    text_alignment: ?HorizontalTextAlignment,

    /// Determines the text transformation of visual sub-title.
    text_transform: ?TextTransform,

    pub const json_field_names = .{
        .font_configuration = "FontConfiguration",
        .text_alignment = "TextAlignment",
        .text_transform = "TextTransform",
    };
};
