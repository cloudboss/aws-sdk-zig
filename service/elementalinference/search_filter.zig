const FilterName = @import("filter_name.zig").FilterName;

/// A filter for a fixture search. It is used in the filters array of a
/// SearchFixtures request.
pub const SearchFilter = struct {
    /// The dimension of the fixture to filter on. Valid values: COMPETITOR.
    name: FilterName,

    /// An array of values to match in the dimension that you specified in name. You
    /// can specify up to 10 values. A fixture appears in the results if it matches
    /// at least one of these values.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
