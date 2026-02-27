/// Describes the criteria for a filter.
pub const FilterCriterion = struct {
    /// The path to filter.
    path: []const u8,

    /// The value to filter.
    values: []const []const u8,

    pub const json_field_names = .{
        .path = "path",
        .values = "values",
    };
};
