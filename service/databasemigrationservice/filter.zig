/// Identifies the name and value of a filter object. This filter is used to
/// limit the
/// number and type of DMS objects that are returned for a particular
/// `Describe*`
/// call or similar operation. Filters are used as an optional parameter for
/// certain API
/// operations.
pub const Filter = struct {
    /// The name of the filter as specified for a `Describe*` or similar
    /// operation.
    name: []const u8,

    /// The filter value, which can specify one or more values used to narrow the
    /// returned
    /// results.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
