const LayerCustomAction = @import("layer_custom_action.zig").LayerCustomAction;
const GeospatialDataSourceItem = @import("geospatial_data_source_item.zig").GeospatialDataSourceItem;
const GeospatialLayerJoinDefinition = @import("geospatial_layer_join_definition.zig").GeospatialLayerJoinDefinition;
const GeospatialLayerDefinition = @import("geospatial_layer_definition.zig").GeospatialLayerDefinition;
const GeospatialLayerType = @import("geospatial_layer_type.zig").GeospatialLayerType;
const TooltipOptions = @import("tooltip_options.zig").TooltipOptions;
const Visibility = @import("visibility.zig").Visibility;

/// The properties for a single geospatial layer.
pub const GeospatialLayerItem = struct {
    /// A list of custom actions for a layer.
    actions: ?[]const LayerCustomAction = null,

    /// The data source for the layer.
    data_source: ?GeospatialDataSourceItem = null,

    /// The join definition properties for a layer.
    join_definition: ?GeospatialLayerJoinDefinition = null,

    /// The label that is displayed for the layer.
    label: ?[]const u8 = null,

    /// The definition properties for a layer.
    layer_definition: ?GeospatialLayerDefinition = null,

    /// The ID of the layer.
    layer_id: []const u8,

    /// The layer type.
    layer_type: ?GeospatialLayerType = null,

    tooltip: ?TooltipOptions = null,

    /// The state of visibility for the layer.
    visibility: ?Visibility = null,

    pub const json_field_names = .{
        .actions = "Actions",
        .data_source = "DataSource",
        .join_definition = "JoinDefinition",
        .label = "Label",
        .layer_definition = "LayerDefinition",
        .layer_id = "LayerId",
        .layer_type = "LayerType",
        .tooltip = "Tooltip",
        .visibility = "Visibility",
    };
};
