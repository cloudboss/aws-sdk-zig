/// Determines the color that is applied to a particular data value.
pub const DataColor = struct {
    /// The color that is applied to the data value.
    color: ?[]const u8 = null,

    /// The data value that the color is applied to.
    data_value: ?f64 = null,

    pub const json_field_names = .{
        .color = "Color",
        .data_value = "DataValue",
    };
};
