const AttributeKeyAndValue = @import("attribute_key_and_value.zig").AttributeKeyAndValue;

/// Represents the output of a GetObjectAttributes response operation.
pub const BatchGetObjectAttributesResponse = struct {
    /// The attribute values that are associated with an object.
    attributes: ?[]const AttributeKeyAndValue = null,

    pub const json_field_names = .{
        .attributes = "Attributes",
    };
};
