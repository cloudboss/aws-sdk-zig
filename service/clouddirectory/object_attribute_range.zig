const AttributeKey = @import("attribute_key.zig").AttributeKey;
const TypedAttributeValueRange = @import("typed_attribute_value_range.zig").TypedAttributeValueRange;

/// A range of attributes.
pub const ObjectAttributeRange = struct {
    /// The key of the attribute that the attribute range covers.
    attribute_key: ?AttributeKey,

    /// The range of attribute values being selected.
    range: ?TypedAttributeValueRange,

    pub const json_field_names = .{
        .attribute_key = "AttributeKey",
        .range = "Range",
    };
};
