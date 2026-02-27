const PivotTableSortBy = @import("pivot_table_sort_by.zig").PivotTableSortBy;

/// The field sort options for a pivot table sort configuration.
pub const PivotFieldSortOptions = struct {
    /// The field ID for the field sort options.
    field_id: []const u8,

    /// The sort by field for the field sort options.
    sort_by: PivotTableSortBy,

    pub const json_field_names = .{
        .field_id = "FieldId",
        .sort_by = "SortBy",
    };
};
