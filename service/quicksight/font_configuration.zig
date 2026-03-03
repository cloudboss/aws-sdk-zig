const FontDecoration = @import("font_decoration.zig").FontDecoration;
const FontSize = @import("font_size.zig").FontSize;
const FontStyle = @import("font_style.zig").FontStyle;
const FontWeight = @import("font_weight.zig").FontWeight;

/// Configures the display properties of the given text.
pub const FontConfiguration = struct {
    /// Determines the color of the text.
    font_color: ?[]const u8 = null,

    /// Determines the appearance of decorative lines on the text.
    font_decoration: ?FontDecoration = null,

    /// The font family that you want to use.
    font_family: ?[]const u8 = null,

    /// The option that determines the text display size.
    font_size: ?FontSize = null,

    /// Determines the text display face that is inherited by the given font family.
    font_style: ?FontStyle = null,

    /// The option that determines the text display weight, or boldness.
    font_weight: ?FontWeight = null,

    pub const json_field_names = .{
        .font_color = "FontColor",
        .font_decoration = "FontDecoration",
        .font_family = "FontFamily",
        .font_size = "FontSize",
        .font_style = "FontStyle",
        .font_weight = "FontWeight",
    };
};
