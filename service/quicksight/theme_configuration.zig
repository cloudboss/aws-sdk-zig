const DataColorPalette = @import("data_color_palette.zig").DataColorPalette;
const SheetStyle = @import("sheet_style.zig").SheetStyle;
const Typography = @import("typography.zig").Typography;
const UIColorPalette = @import("ui_color_palette.zig").UIColorPalette;

/// The theme configuration. This configuration contains all of the display
/// properties for
/// a theme.
pub const ThemeConfiguration = struct {
    /// Color properties that apply to chart data colors.
    data_color_palette: ?DataColorPalette = null,

    /// Display options related to sheets.
    sheet: ?SheetStyle = null,

    typography: ?Typography = null,

    /// Color properties that apply to the UI and to charts, excluding the colors
    /// that apply
    /// to data.
    ui_color_palette: ?UIColorPalette = null,

    pub const json_field_names = .{
        .data_color_palette = "DataColorPalette",
        .sheet = "Sheet",
        .typography = "Typography",
        .ui_color_palette = "UIColorPalette",
    };
};
