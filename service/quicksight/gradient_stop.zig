/// Determines the gradient stop configuration.
pub const GradientStop = struct {
    /// Determines the color.
    color: ?[]const u8 = null,

    /// Determines the data value.
    data_value: ?f64 = null,

    /// Determines gradient offset value.
    gradient_offset: f64 = 0,

    pub const json_field_names = .{
        .color = "Color",
        .data_value = "DataValue",
        .gradient_offset = "GradientOffset",
    };
};
