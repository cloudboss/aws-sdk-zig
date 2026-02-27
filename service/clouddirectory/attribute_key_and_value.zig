const AttributeKey = @import("attribute_key.zig").AttributeKey;
const TypedAttributeValue = @import("typed_attribute_value.zig").TypedAttributeValue;

/// The combination of an attribute key and an attribute value.
pub const AttributeKeyAndValue = struct {
    /// The key of the attribute.
    key: AttributeKey,

    /// The value of the attribute.
    value: TypedAttributeValue,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
