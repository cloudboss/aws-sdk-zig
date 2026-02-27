const BorderStyle = @import("border_style.zig").BorderStyle;

/// Display options related to tiles on a sheet.
pub const TileStyle = struct {
    /// The background color of a tile.
    background_color: ?[]const u8,

    /// The border around a tile.
    border: ?BorderStyle,

    /// The border radius of a tile.
    border_radius: ?[]const u8,

    /// The padding of a tile.
    padding: ?[]const u8,

    pub const json_field_names = .{
        .background_color = "BackgroundColor",
        .border = "Border",
        .border_radius = "BorderRadius",
        .padding = "Padding",
    };
};
