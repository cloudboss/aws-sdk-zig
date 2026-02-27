/// The input structure for Reverse Geocoding operation type.
pub const ReverseGeocodingConfig = struct {
    /// The field name for the data that describes x-axis coordinate, eg. longitude
    /// of a point.
    x_attribute_name: []const u8,

    /// The field name for the data that describes y-axis coordinate, eg. latitude
    /// of a point.
    y_attribute_name: []const u8,

    pub const json_field_names = .{
        .x_attribute_name = "XAttributeName",
        .y_attribute_name = "YAttributeName",
    };
};
