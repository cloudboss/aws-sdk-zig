/// A filter name and value pair that is used to return a more specific list of
/// results
/// from a list operation. Filters can be used to match a set of resources by
/// specific
/// criteria, such as tags, attributes, or IDs.
pub const Filter = struct {
    /// The name of the filter. Filter names are case-sensitive.
    name: ?[]const u8,

    /// The filter values. Filter values are case-sensitive.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
