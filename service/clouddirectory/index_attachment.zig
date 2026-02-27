const AttributeKeyAndValue = @import("attribute_key_and_value.zig").AttributeKeyAndValue;

/// Represents an index and an attached object.
pub const IndexAttachment = struct {
    /// The indexed attribute values.
    indexed_attributes: ?[]const AttributeKeyAndValue,

    /// In response to ListIndex, the `ObjectIdentifier` of the object attached to
    /// the index. In response to ListAttachedIndices, the `ObjectIdentifier` of the
    /// index attached to the object. This field will always contain the
    /// `ObjectIdentifier` of the object on the opposite side of the attachment
    /// specified in the query.
    object_identifier: ?[]const u8,

    pub const json_field_names = .{
        .indexed_attributes = "IndexedAttributes",
        .object_identifier = "ObjectIdentifier",
    };
};
