const VisualInteractionOptions = @import("visual_interaction_options.zig").VisualInteractionOptions;
const LegendOptions = @import("legend_options.zig").LegendOptions;
const GeospatialLayerItem = @import("geospatial_layer_item.zig").GeospatialLayerItem;
const GeospatialMapState = @import("geospatial_map_state.zig").GeospatialMapState;
const GeospatialMapStyle = @import("geospatial_map_style.zig").GeospatialMapStyle;

/// The map definition that defines map state, map style, and geospatial layers.
pub const GeospatialLayerMapConfiguration = struct {
    interactions: ?VisualInteractionOptions,

    legend: ?LegendOptions,

    /// The geospatial layers to visualize on the map.
    map_layers: ?[]const GeospatialLayerItem,

    /// The map state properties for the map.
    map_state: ?GeospatialMapState,

    /// The map style properties for the map.
    map_style: ?GeospatialMapStyle,

    pub const json_field_names = .{
        .interactions = "Interactions",
        .legend = "Legend",
        .map_layers = "MapLayers",
        .map_state = "MapState",
        .map_style = "MapStyle",
    };
};
