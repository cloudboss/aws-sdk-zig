/// The color to be used in the heatmap point style.
pub const GeospatialHeatmapDataColor = struct {
    /// The hex color to be used in the heatmap point style.
    color: []const u8,

    pub const json_field_names = .{
        .color = "Color",
    };
};
