const GeospatialCategoricalColor = @import("geospatial_categorical_color.zig").GeospatialCategoricalColor;
const GeospatialGradientColor = @import("geospatial_gradient_color.zig").GeospatialGradientColor;
const GeospatialSolidColor = @import("geospatial_solid_color.zig").GeospatialSolidColor;

/// The visualization properties for solid, gradient, and categorical colors.
pub const GeospatialColor = struct {
    /// The visualization properties for the categorical color.
    categorical: ?GeospatialCategoricalColor,

    /// The visualization properties for the gradient color.
    gradient: ?GeospatialGradientColor,

    /// The visualization properties for the solid color.
    solid: ?GeospatialSolidColor,

    pub const json_field_names = .{
        .categorical = "Categorical",
        .gradient = "Gradient",
        .solid = "Solid",
    };
};
