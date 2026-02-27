/// The gradient step color for a single step.
pub const GeospatialGradientStepColor = struct {
    /// The color and opacity values for the gradient step color.
    color: []const u8,

    /// The data value for the gradient step color.
    data_value: f64 = 0,

    pub const json_field_names = .{
        .color = "Color",
        .data_value = "DataValue",
    };
};
