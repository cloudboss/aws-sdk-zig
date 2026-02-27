/// The categorical data color for a single category.
pub const GeospatialCategoricalDataColor = struct {
    /// The color and opacity values for the category data color.
    color: []const u8,

    /// The data value for the category data color.
    data_value: []const u8,

    pub const json_field_names = .{
        .color = "Color",
        .data_value = "DataValue",
    };
};
