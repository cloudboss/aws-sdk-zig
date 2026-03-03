/// A filter name and value pair that is used to return more specific results
/// from a describe or list operation. You can use filters can be used to match
/// a set of resources by specific criteria, such as tags, attributes, or IDs.
pub const Filter = struct {
    /// The name of an attribute to use as a filter.
    attribute: ?[]const u8 = null,

    /// The type of search (For example, eq, geq, leq)
    operation: ?[]const u8 = null,

    /// Value of the filter.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .attribute = "Attribute",
        .operation = "Operation",
        .value = "Value",
    };
};
