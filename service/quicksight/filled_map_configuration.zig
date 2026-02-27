const FilledMapFieldWells = @import("filled_map_field_wells.zig").FilledMapFieldWells;
const VisualInteractionOptions = @import("visual_interaction_options.zig").VisualInteractionOptions;
const LegendOptions = @import("legend_options.zig").LegendOptions;
const GeospatialMapStyleOptions = @import("geospatial_map_style_options.zig").GeospatialMapStyleOptions;
const FilledMapSortConfiguration = @import("filled_map_sort_configuration.zig").FilledMapSortConfiguration;
const TooltipOptions = @import("tooltip_options.zig").TooltipOptions;
const GeospatialWindowOptions = @import("geospatial_window_options.zig").GeospatialWindowOptions;

/// The configuration for a `FilledMapVisual`.
pub const FilledMapConfiguration = struct {
    /// The field wells of the visual.
    field_wells: ?FilledMapFieldWells,

    /// The general visual interactions setup for a visual.
    interactions: ?VisualInteractionOptions,

    /// The legend display setup of the visual.
    legend: ?LegendOptions,

    /// The map style options of the filled map visual.
    map_style_options: ?GeospatialMapStyleOptions,

    /// The sort configuration of a `FilledMapVisual`.
    sort_configuration: ?FilledMapSortConfiguration,

    /// The tooltip display setup of the visual.
    tooltip: ?TooltipOptions,

    /// The window options of the filled map visual.
    window_options: ?GeospatialWindowOptions,

    pub const json_field_names = .{
        .field_wells = "FieldWells",
        .interactions = "Interactions",
        .legend = "Legend",
        .map_style_options = "MapStyleOptions",
        .sort_configuration = "SortConfiguration",
        .tooltip = "Tooltip",
        .window_options = "WindowOptions",
    };
};
