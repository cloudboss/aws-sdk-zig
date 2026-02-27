const SheetBackgroundStyle = @import("sheet_background_style.zig").SheetBackgroundStyle;
const TileStyle = @import("tile_style.zig").TileStyle;
const TileLayoutStyle = @import("tile_layout_style.zig").TileLayoutStyle;

/// The theme display options for sheets.
pub const SheetStyle = struct {
    /// The background for sheets.
    background: ?SheetBackgroundStyle,

    /// The display options for tiles.
    tile: ?TileStyle,

    /// The layout options for tiles.
    tile_layout: ?TileLayoutStyle,

    pub const json_field_names = .{
        .background = "Background",
        .tile = "Tile",
        .tile_layout = "TileLayout",
    };
};
