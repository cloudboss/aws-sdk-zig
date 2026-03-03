const SheetBackgroundStyle = @import("sheet_background_style.zig").SheetBackgroundStyle;
const TileStyle = @import("tile_style.zig").TileStyle;
const TileLayoutStyle = @import("tile_layout_style.zig").TileLayoutStyle;

/// The theme display options for sheets.
pub const SheetStyle = struct {
    /// The background for sheets.
    background: ?SheetBackgroundStyle = null,

    /// The display options for tiles.
    tile: ?TileStyle = null,

    /// The layout options for tiles.
    tile_layout: ?TileLayoutStyle = null,

    pub const json_field_names = .{
        .background = "Background",
        .tile = "Tile",
        .tile_layout = "TileLayout",
    };
};
