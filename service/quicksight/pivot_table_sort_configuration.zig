const PivotFieldSortOptions = @import("pivot_field_sort_options.zig").PivotFieldSortOptions;

/// The sort configuration for a `PivotTableVisual`.
pub const PivotTableSortConfiguration = struct {
    /// The field sort options for a pivot table sort configuration.
    field_sort_options: ?[]const PivotFieldSortOptions,

    pub const json_field_names = .{
        .field_sort_options = "FieldSortOptions",
    };
};
