const FontConfiguration = @import("font_configuration.zig").FontConfiguration;
const HorizontalTextAlignment = @import("horizontal_text_alignment.zig").HorizontalTextAlignment;
const Visibility = @import("visibility.zig").Visibility;

/// The options that determine the title styles for each small multiples
/// panel.
pub const PanelTitleOptions = struct {
    font_configuration: ?FontConfiguration = null,

    /// Sets the horizontal text alignment of the title within each panel.
    horizontal_text_alignment: ?HorizontalTextAlignment = null,

    /// Determines whether or not panel titles are displayed.
    visibility: ?Visibility = null,

    pub const json_field_names = .{
        .font_configuration = "FontConfiguration",
        .horizontal_text_alignment = "HorizontalTextAlignment",
        .visibility = "Visibility",
    };
};
