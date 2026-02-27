const FilterGroup = @import("filter_group.zig").FilterGroup;
const Include = @import("include.zig").Include;

/// Defines how to filter the objects coming in for calculated attributes.
pub const Filter = struct {
    /// Holds the list of Filter groups within the Filter definition.
    groups: []const FilterGroup,

    /// Define whether to include or exclude objects for Calculated Attributed
    /// calculation that
    /// fit the filter groups criteria.
    include: Include,

    pub const json_field_names = .{
        .groups = "Groups",
        .include = "Include",
    };
};
