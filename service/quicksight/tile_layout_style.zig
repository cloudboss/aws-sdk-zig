const GutterStyle = @import("gutter_style.zig").GutterStyle;
const MarginStyle = @import("margin_style.zig").MarginStyle;

/// The display options for the layout of tiles on a sheet.
pub const TileLayoutStyle = struct {
    /// The gutter settings that apply between tiles.
    gutter: ?GutterStyle,

    /// The margin settings that apply around the outside edge of sheets.
    margin: ?MarginStyle,

    pub const json_field_names = .{
        .gutter = "Gutter",
        .margin = "Margin",
    };
};
