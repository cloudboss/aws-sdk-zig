/// The input structure for Map Matching operation type.
pub const MapMatchingConfig = struct {
    /// The field name for the data that describes the identifier representing a
    /// collection of GPS points belonging to an individual trace.
    id_attribute_name: []const u8,

    /// The name of the timestamp attribute.
    timestamp_attribute_name: []const u8,

    /// The name of the X-attribute
    x_attribute_name: []const u8,

    /// The name of the Y-attribute
    y_attribute_name: []const u8,

    pub const json_field_names = .{
        .id_attribute_name = "IdAttributeName",
        .timestamp_attribute_name = "TimestampAttributeName",
        .x_attribute_name = "XAttributeName",
        .y_attribute_name = "YAttributeName",
    };
};
