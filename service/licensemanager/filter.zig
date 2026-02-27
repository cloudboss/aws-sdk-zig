/// A filter name and value pair that is used to return more specific results
/// from a
/// describe operation. Filters can be used to match a set of resources by
/// specific criteria,
/// such as tags, attributes, or IDs.
pub const Filter = struct {
    /// Name of the filter. Filter names are case-sensitive.
    name: ?[]const u8,

    /// The value of the filter, which is case-sensitive. You can only specify one
    /// value for the filter.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
