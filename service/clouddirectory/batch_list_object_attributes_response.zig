const AttributeKeyAndValue = @import("attribute_key_and_value.zig").AttributeKeyAndValue;

/// Represents the output of a ListObjectAttributes response operation.
pub const BatchListObjectAttributesResponse = struct {
    /// The attributes map that is associated with the object. `AttributeArn` is the
    /// key; attribute value is the value.
    attributes: ?[]const AttributeKeyAndValue,

    /// The pagination token.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .next_token = "NextToken",
    };
};
