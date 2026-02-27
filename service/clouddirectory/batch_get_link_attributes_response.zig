const AttributeKeyAndValue = @import("attribute_key_and_value.zig").AttributeKeyAndValue;

/// Represents the output of a GetLinkAttributes response operation.
pub const BatchGetLinkAttributesResponse = struct {
    /// The attributes that are associated with the typed link.
    attributes: ?[]const AttributeKeyAndValue,

    pub const json_field_names = .{
        .attributes = "Attributes",
    };
};
