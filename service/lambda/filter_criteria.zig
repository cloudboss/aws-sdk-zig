const Filter = @import("filter.zig").Filter;

/// An object that contains the filters for an event source.
pub const FilterCriteria = struct {
    /// A list of filters.
    filters: ?[]const Filter,

    pub const json_field_names = .{
        .filters = "Filters",
    };
};
