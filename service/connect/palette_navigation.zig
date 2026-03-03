/// Contains color configuration for navigation elements in a workspace theme.
pub const PaletteNavigation = struct {
    /// The background color of the navigation area.
    background: ?[]const u8 = null,

    /// Whether to invert the colors of action buttons in the navigation area.
    invert_actions_colors: bool = false,

    /// The text color in the navigation area.
    text: ?[]const u8 = null,

    /// The text color for active navigation items.
    text_active: ?[]const u8 = null,

    /// The background color for active navigation items.
    text_background_active: ?[]const u8 = null,

    /// The background color when hovering over navigation text.
    text_background_hover: ?[]const u8 = null,

    /// The text color when hovering over navigation items.
    text_hover: ?[]const u8 = null,

    pub const json_field_names = .{
        .background = "Background",
        .invert_actions_colors = "InvertActionsColors",
        .text = "Text",
        .text_active = "TextActive",
        .text_background_active = "TextBackgroundActive",
        .text_background_hover = "TextBackgroundHover",
        .text_hover = "TextHover",
    };
};
