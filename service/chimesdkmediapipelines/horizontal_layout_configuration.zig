const TileOrder = @import("tile_order.zig").TileOrder;
const HorizontalTilePosition = @import("horizontal_tile_position.zig").HorizontalTilePosition;

/// Defines the configuration settings for the horizontal layout.
pub const HorizontalLayoutConfiguration = struct {
    /// Specifies the aspect ratio of all video tiles.
    tile_aspect_ratio: ?[]const u8,

    /// The maximum number of video tiles to display.
    tile_count: ?i32,

    /// Sets the automatic ordering of the video tiles.
    tile_order: ?TileOrder,

    /// Sets the position of horizontal tiles.
    tile_position: ?HorizontalTilePosition,

    pub const json_field_names = .{
        .tile_aspect_ratio = "TileAspectRatio",
        .tile_count = "TileCount",
        .tile_order = "TileOrder",
        .tile_position = "TilePosition",
    };
};
