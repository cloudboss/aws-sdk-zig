/// An entity attribute that's unique to a specific entity.
pub const UniqueAttribute = struct {
    /// A string representation of the path to a given attribute or sub-attribute.
    /// Supports JMESPath.
    attribute_path: []const u8,

    /// The value of the attribute. This is a `Document` type. This type is not
    /// supported by Java V1, Go V1, and older versions of the CLI.
    attribute_value: []const u8,

    pub const json_field_names = .{
        .attribute_path = "AttributePath",
        .attribute_value = "AttributeValue",
    };
};
