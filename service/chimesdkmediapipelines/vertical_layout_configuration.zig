const TileOrder = @import("tile_order.zig").TileOrder;
const VerticalTilePosition = @import("vertical_tile_position.zig").VerticalTilePosition;

/// Defines the configuration settings for a vertical layout.
pub const VerticalLayoutConfiguration = struct {
    /// Sets the aspect ratio of the video tiles, such as 16:9.
    tile_aspect_ratio: ?[]const u8,

    /// The maximum number of tiles to display.
    tile_count: ?i32,

    /// Sets the automatic ordering of the video tiles.
    tile_order: ?TileOrder,

    /// Sets the position of vertical tiles.
    tile_position: ?VerticalTilePosition,

    pub const json_field_names = .{
        .tile_aspect_ratio = "TileAspectRatio",
        .tile_count = "TileCount",
        .tile_order = "TileOrder",
        .tile_position = "TilePosition",
    };
};
