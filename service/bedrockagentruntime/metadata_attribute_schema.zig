const AttributeType = @import("attribute_type.zig").AttributeType;

/// Details about a metadata attribute.
pub const MetadataAttributeSchema = struct {
    /// The attribute's description.
    description: []const u8,

    /// The attribute's key.
    key: []const u8,

    /// The attribute's type.
    type: AttributeType,

    pub const json_field_names = .{
        .description = "description",
        .key = "key",
        .type = "type",
    };
};
