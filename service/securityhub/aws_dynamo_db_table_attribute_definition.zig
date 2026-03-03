/// Contains a definition of an attribute for the table.
pub const AwsDynamoDbTableAttributeDefinition = struct {
    /// The name of the attribute.
    attribute_name: ?[]const u8 = null,

    /// The type of the attribute.
    attribute_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .attribute_type = "AttributeType",
    };
};
