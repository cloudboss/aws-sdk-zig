const DocumentAttributeValue = @import("document_attribute_value.zig").DocumentAttributeValue;

/// A document attribute or metadata field. To create custom document
/// attributes, see
/// [Custom
/// attributes](https://docs.aws.amazon.com/kendra/latest/dg/custom-attributes.html).
pub const DocumentAttribute = struct {
    /// The identifier for the attribute.
    key: []const u8,

    /// The value of the attribute.
    value: DocumentAttributeValue,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
