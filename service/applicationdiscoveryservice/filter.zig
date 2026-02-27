/// A filter that can use conditional operators.
///
/// For more information about filters, see [Querying Discovered
/// Configuration
/// Items](https://docs.aws.amazon.com/application-discovery/latest/userguide/discovery-api-queries.html) in the *Amazon Web Services Application Discovery Service User
/// Guide*.
pub const Filter = struct {
    /// A conditional operator. The following operators are valid: EQUALS,
    /// NOT_EQUALS,
    /// CONTAINS, NOT_CONTAINS. If you specify multiple filters, the system utilizes
    /// all filters as
    /// though concatenated by *AND*. If you specify multiple values for a
    /// particular filter, the system differentiates the values using *OR*. Calling
    /// either *DescribeConfigurations* or *ListConfigurations*
    /// returns attributes of matching configuration items.
    condition: []const u8,

    /// The name of the filter.
    name: []const u8,

    /// A string value on which to filter. For example, if you choose the
    /// `destinationServer.osVersion` filter name, you could specify `Ubuntu`
    /// for the value.
    values: []const []const u8,

    pub const json_field_names = .{
        .condition = "condition",
        .name = "name",
        .values = "values",
    };
};
