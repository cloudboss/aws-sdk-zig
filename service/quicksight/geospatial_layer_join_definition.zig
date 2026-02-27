const GeospatialLayerColorField = @import("geospatial_layer_color_field.zig").GeospatialLayerColorField;
const UnaggregatedField = @import("unaggregated_field.zig").UnaggregatedField;

/// The custom actions for a layer.
pub const GeospatialLayerJoinDefinition = struct {
    /// The geospatial color field for the join definition.
    color_field: ?GeospatialLayerColorField,

    dataset_key_field: ?UnaggregatedField,

    /// The name of the field or property in the geospatial data source.
    shape_key_field: ?[]const u8,

    pub const json_field_names = .{
        .color_field = "ColorField",
        .dataset_key_field = "DatasetKeyField",
        .shape_key_field = "ShapeKeyField",
    };
};
