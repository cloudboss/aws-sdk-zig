const DocumentAttributeValueCountPair = @import("document_attribute_value_count_pair.zig").DocumentAttributeValueCountPair;
const DocumentAttributeValueType = @import("document_attribute_value_type.zig").DocumentAttributeValueType;

/// The facet values for the documents in the response.
pub const FacetResult = struct {
    /// The key for the facet values. This is the same as the `DocumentAttributeKey`
    /// provided in the query.
    document_attribute_key: ?[]const u8,

    /// An array of key/value pairs, where the key is the value of the attribute and
    /// the count
    /// is the number of documents that share the key value.
    document_attribute_value_count_pairs: ?[]const DocumentAttributeValueCountPair,

    /// The data type of the facet value. This is the same as the type defined for
    /// the index
    /// field when it was created.
    document_attribute_value_type: ?DocumentAttributeValueType,

    pub const json_field_names = .{
        .document_attribute_key = "DocumentAttributeKey",
        .document_attribute_value_count_pairs = "DocumentAttributeValueCountPairs",
        .document_attribute_value_type = "DocumentAttributeValueType",
    };
};
