const GeospatialCategoricalDataColor = @import("geospatial_categorical_data_color.zig").GeospatialCategoricalDataColor;
const GeospatialNullDataSettings = @import("geospatial_null_data_settings.zig").GeospatialNullDataSettings;
const Visibility = @import("visibility.zig").Visibility;

/// The definition for a categorical color.
pub const GeospatialCategoricalColor = struct {
    /// A list of categorical data colors for each category.
    category_data_colors: []const GeospatialCategoricalDataColor,

    /// The default opacity of a categorical color.
    default_opacity: ?f64,

    /// The null data visualization settings.
    null_data_settings: ?GeospatialNullDataSettings,

    /// The state of visibility for null data.
    null_data_visibility: ?Visibility,

    pub const json_field_names = .{
        .category_data_colors = "CategoryDataColors",
        .default_opacity = "DefaultOpacity",
        .null_data_settings = "NullDataSettings",
        .null_data_visibility = "NullDataVisibility",
    };
};
