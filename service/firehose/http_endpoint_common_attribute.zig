/// Describes the metadata that's delivered to the specified HTTP endpoint
/// destination.
pub const HttpEndpointCommonAttribute = struct {
    /// The name of the HTTP endpoint common attribute.
    attribute_name: []const u8,

    /// The value of the HTTP endpoint common attribute.
    attribute_value: []const u8,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .attribute_value = "AttributeValue",
    };
};
