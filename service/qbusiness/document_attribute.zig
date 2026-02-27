const DocumentAttributeValue = @import("document_attribute_value.zig").DocumentAttributeValue;

/// A document attribute or metadata field.
pub const DocumentAttribute = struct {
    /// The identifier for the attribute.
    name: []const u8,

    /// The value of the attribute.
    value: DocumentAttributeValue,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
