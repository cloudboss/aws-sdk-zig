const ScalarAttributeType = @import("scalar_attribute_type.zig").ScalarAttributeType;

/// Represents an attribute for describing the schema for the table and indexes.
pub const AttributeDefinition = struct {
    /// A name for the attribute.
    attribute_name: []const u8,

    /// The data type for the attribute, where:
    ///
    /// * `S` - the attribute is of type String
    ///
    /// * `N` - the attribute is of type Number
    ///
    /// * `B` - the attribute is of type Binary
    attribute_type: ScalarAttributeType,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .attribute_type = "AttributeType",
    };
};
