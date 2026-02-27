/// Contains color configuration for header elements in a workspace theme.
pub const PaletteHeader = struct {
    /// The background color of the header.
    background: ?[]const u8,

    /// Whether to invert the colors of action buttons in the header.
    invert_actions_colors: bool = false,

    /// The text color in the header.
    text: ?[]const u8,

    /// The text color when hovering over header elements.
    text_hover: ?[]const u8,

    pub const json_field_names = .{
        .background = "Background",
        .invert_actions_colors = "InvertActionsColors",
        .text = "Text",
        .text_hover = "TextHover",
    };
};
