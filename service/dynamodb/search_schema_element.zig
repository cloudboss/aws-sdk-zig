const SearchSchemaElementType = @import("search_schema_element_type.zig").SearchSchemaElementType;

/// An element in the search schema of a vector index.
pub const SearchSchemaElement = struct {
    /// The name of the attribute.
    attribute_name: []const u8,

    /// The role of the attribute in the search schema. Valid values:
    ///
    /// * `HASH` - A partition key that partitions the vector index for
    /// independent scaling. When specified, you must provide this attribute's value
    /// in the `SearchConditionExpression`.
    ///
    /// * `INLINE_FILTER` - An attribute projected into the vector index
    /// for filtering at the storage layer during search. Inline filters are
    /// optional in the `SearchConditionExpression`.
    search_schema_element_type: SearchSchemaElementType,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .search_schema_element_type = "SearchSchemaElementType",
    };
};
