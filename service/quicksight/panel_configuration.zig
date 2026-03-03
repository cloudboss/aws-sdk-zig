const Visibility = @import("visibility.zig").Visibility;
const PanelBorderStyle = @import("panel_border_style.zig").PanelBorderStyle;
const PanelTitleOptions = @import("panel_title_options.zig").PanelTitleOptions;

/// A collection of options that configure how each panel displays in a small
/// multiples chart.
pub const PanelConfiguration = struct {
    /// Sets the background color for each panel.
    background_color: ?[]const u8 = null,

    /// Determines whether or not a background for each small multiples panel is
    /// rendered.
    background_visibility: ?Visibility = null,

    /// Sets the line color of panel borders.
    border_color: ?[]const u8 = null,

    /// Sets the line style of panel borders.
    border_style: ?PanelBorderStyle = null,

    /// Sets the line thickness of panel borders.
    border_thickness: ?[]const u8 = null,

    /// Determines whether or not each panel displays a border.
    border_visibility: ?Visibility = null,

    /// Sets the total amount of negative space to display between sibling panels.
    gutter_spacing: ?[]const u8 = null,

    /// Determines whether or not negative space between sibling panels is rendered.
    gutter_visibility: ?Visibility = null,

    /// Configures the title display within each small multiples panel.
    title: ?PanelTitleOptions = null,

    pub const json_field_names = .{
        .background_color = "BackgroundColor",
        .background_visibility = "BackgroundVisibility",
        .border_color = "BorderColor",
        .border_style = "BorderStyle",
        .border_thickness = "BorderThickness",
        .border_visibility = "BorderVisibility",
        .gutter_spacing = "GutterSpacing",
        .gutter_visibility = "GutterVisibility",
        .title = "Title",
    };
};
