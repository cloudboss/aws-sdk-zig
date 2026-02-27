const FilterAttribute = @import("filter_attribute.zig").FilterAttribute;

/// Specifies the filters to use on the metadata attributes/fields in the
/// knowledge base data sources before returning results.
pub const RetrievalFilter = union(enum) {
    /// Knowledge base data sources are returned if their metadata attributes
    /// fulfill all the filter conditions inside this list.
    and_all: ?[]const RetrievalFilter,
    /// Knowledge base data sources are returned if they contain a metadata
    /// attribute whose name matches the key and whose value matches the value in
    /// this object.
    ///
    /// The following example would return data sources with an animal attribute
    /// whose value is 'cat': `"equals": { "key": "animal", "value": "cat" }`
    equals: ?FilterAttribute,
    /// Knowledge base data sources are returned if they contain a metadata
    /// attribute whose name matches the key and whose value is greater than the
    /// value in this object.
    ///
    /// The following example would return data sources with an year attribute whose
    /// value is greater than '1989': `"greaterThan": { "key": "year", "value": 1989
    /// }`
    greater_than: ?FilterAttribute,
    /// Knowledge base data sources are returned if they contain a metadata
    /// attribute whose name matches the key and whose value is greater than or
    /// equal to the value in this object.
    ///
    /// The following example would return data sources with an year attribute whose
    /// value is greater than or equal to '1989': `"greaterThanOrEquals": { "key":
    /// "year", "value": 1989 }`
    greater_than_or_equals: ?FilterAttribute,
    /// Knowledge base data sources are returned if they contain a metadata
    /// attribute whose name matches the key and whose value is in the list
    /// specified in the value in this object.
    ///
    /// The following example would return data sources with an animal attribute
    /// that is either 'cat' or 'dog': `"in": { "key": "animal", "value": ["cat",
    /// "dog"] }`
    in: ?FilterAttribute,
    /// Knowledge base data sources are returned if they contain a metadata
    /// attribute whose name matches the key and whose value is less than the value
    /// in this object.
    ///
    /// The following example would return data sources with an year attribute whose
    /// value is less than to '1989': `"lessThan": { "key": "year", "value": 1989 }`
    less_than: ?FilterAttribute,
    /// Knowledge base data sources are returned if they contain a metadata
    /// attribute whose name matches the key and whose value is less than or equal
    /// to the value in this object.
    ///
    /// The following example would return data sources with an year attribute whose
    /// value is less than or equal to '1989': `"lessThanOrEquals": { "key": "year",
    /// "value": 1989 }`
    less_than_or_equals: ?FilterAttribute,
    /// Knowledge base data sources are returned if they contain a metadata
    /// attribute whose name matches the key and whose value is a list that contains
    /// the value as one of its members.
    ///
    /// The following example would return data sources with an animals attribute
    /// that is a list containing a cat member (for example, `["dog", "cat"]`):
    /// `"listContains": { "key": "animals", "value": "cat" }`
    list_contains: ?FilterAttribute,
    /// Knowledge base data sources that contain a metadata attribute whose name
    /// matches the key and whose value doesn't match the value in this object are
    /// returned.
    ///
    /// The following example would return data sources that don't contain an animal
    /// attribute whose value is 'cat': `"notEquals": { "key": "animal", "value":
    /// "cat" }`
    not_equals: ?FilterAttribute,
    /// Knowledge base data sources are returned if they contain a metadata
    /// attribute whose name matches the key and whose value isn't in the list
    /// specified in the value in this object.
    ///
    /// The following example would return data sources whose animal attribute is
    /// neither 'cat' nor 'dog': `"notIn": { "key": "animal", "value": ["cat",
    /// "dog"] }`
    not_in: ?FilterAttribute,
    /// Knowledge base data sources are returned if their metadata attributes
    /// fulfill at least one of the filter conditions inside this list.
    or_all: ?[]const RetrievalFilter,
    /// Knowledge base data sources are returned if they contain a metadata
    /// attribute whose name matches the key and whose value starts with the value
    /// in this object. This filter is currently only supported for Amazon
    /// OpenSearch Serverless vector stores.
    ///
    /// The following example would return data sources with an animal attribute
    /// starts with 'ca' (for example, 'cat' or 'camel'). `"startsWith": { "key":
    /// "animal", "value": "ca" }`
    starts_with: ?FilterAttribute,
    /// Knowledge base data sources are returned if they contain a metadata
    /// attribute whose name matches the key and whose value is one of the
    /// following:
    ///
    /// A string that contains the value as a substring. The following example would
    /// return data sources with an animal attribute that contains the substring at
    /// (for example, 'cat'): `"stringContains": { "key": "animal", "value": "at" }`
    ///
    /// A list with a member that contains the value as a substring. The following
    /// example would return data sources with an animals attribute that is a list
    /// containing a member that contains the substring at (for example, `["dog",
    /// "cat"]`): `"stringContains": { "key": "animals", "value": "at" }`
    string_contains: ?FilterAttribute,

    pub const json_field_names = .{
        .and_all = "andAll",
        .equals = "equals",
        .greater_than = "greaterThan",
        .greater_than_or_equals = "greaterThanOrEquals",
        .in = "in",
        .less_than = "lessThan",
        .less_than_or_equals = "lessThanOrEquals",
        .list_contains = "listContains",
        .not_equals = "notEquals",
        .not_in = "notIn",
        .or_all = "orAll",
        .starts_with = "startsWith",
        .string_contains = "stringContains",
    };
};
