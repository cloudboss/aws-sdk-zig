const GeospatialNullDataSettings = @import("geospatial_null_data_settings.zig").GeospatialNullDataSettings;
const Visibility = @import("visibility.zig").Visibility;
const GeospatialGradientStepColor = @import("geospatial_gradient_step_color.zig").GeospatialGradientStepColor;

/// The definition for a gradient color.
pub const GeospatialGradientColor = struct {
    /// The default opacity for the gradient color.
    default_opacity: ?f64 = null,

    /// The null data visualization settings.
    null_data_settings: ?GeospatialNullDataSettings = null,

    /// The state of visibility for null data.
    null_data_visibility: ?Visibility = null,

    /// A list of gradient step colors for the gradient.
    step_colors: []const GeospatialGradientStepColor,

    pub const json_field_names = .{
        .default_opacity = "DefaultOpacity",
        .null_data_settings = "NullDataSettings",
        .null_data_visibility = "NullDataVisibility",
        .step_colors = "StepColors",
    };
};
