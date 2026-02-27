const TypedAttributeValue = @import("typed_attribute_value.zig").TypedAttributeValue;

/// Identifies the attribute name and value for a typed link.
pub const AttributeNameAndValue = struct {
    /// The attribute name of the typed link.
    attribute_name: []const u8,

    /// The value for the typed link.
    value: TypedAttributeValue,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .value = "Value",
    };
};
