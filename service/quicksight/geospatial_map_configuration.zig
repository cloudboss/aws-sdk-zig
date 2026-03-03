const GeospatialMapFieldWells = @import("geospatial_map_field_wells.zig").GeospatialMapFieldWells;
const VisualInteractionOptions = @import("visual_interaction_options.zig").VisualInteractionOptions;
const LegendOptions = @import("legend_options.zig").LegendOptions;
const GeospatialMapStyleOptions = @import("geospatial_map_style_options.zig").GeospatialMapStyleOptions;
const GeospatialPointStyleOptions = @import("geospatial_point_style_options.zig").GeospatialPointStyleOptions;
const TooltipOptions = @import("tooltip_options.zig").TooltipOptions;
const VisualPalette = @import("visual_palette.zig").VisualPalette;
const GeospatialWindowOptions = @import("geospatial_window_options.zig").GeospatialWindowOptions;

/// The configuration of a `GeospatialMapVisual`.
pub const GeospatialMapConfiguration = struct {
    /// The field wells of the visual.
    field_wells: ?GeospatialMapFieldWells = null,

    /// The general visual interactions setup for a visual.
    interactions: ?VisualInteractionOptions = null,

    /// The legend display setup of the visual.
    legend: ?LegendOptions = null,

    /// The map style options of the geospatial map.
    map_style_options: ?GeospatialMapStyleOptions = null,

    /// The point style options of the geospatial map.
    point_style_options: ?GeospatialPointStyleOptions = null,

    /// The tooltip display setup of the visual.
    tooltip: ?TooltipOptions = null,

    visual_palette: ?VisualPalette = null,

    /// The window options of the geospatial map.
    window_options: ?GeospatialWindowOptions = null,

    pub const json_field_names = .{
        .field_wells = "FieldWells",
        .interactions = "Interactions",
        .legend = "Legend",
        .map_style_options = "MapStyleOptions",
        .point_style_options = "PointStyleOptions",
        .tooltip = "Tooltip",
        .visual_palette = "VisualPalette",
        .window_options = "WindowOptions",
    };
};
