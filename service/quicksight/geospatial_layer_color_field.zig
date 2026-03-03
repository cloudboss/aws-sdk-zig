const DimensionField = @import("dimension_field.zig").DimensionField;
const MeasureField = @import("measure_field.zig").MeasureField;

/// The color field that defines a gradient or categorical style.
pub const GeospatialLayerColorField = struct {
    /// A list of color dimension fields.
    color_dimensions_fields: ?[]const DimensionField = null,

    /// A list of color measure fields.
    color_values_fields: ?[]const MeasureField = null,

    pub const json_field_names = .{
        .color_dimensions_fields = "ColorDimensionsFields",
        .color_values_fields = "ColorValuesFields",
    };
};
