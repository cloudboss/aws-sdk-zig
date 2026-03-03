/// The filter name and value pair that is used to return a more specific list
/// of results. Filters can be used to match a set of resources by various
/// criteria, such as `offerId` or `productId`.
pub const Filter = struct {
    /// The name of the filter.
    name: ?[]const u8 = null,

    /// The filter value.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
