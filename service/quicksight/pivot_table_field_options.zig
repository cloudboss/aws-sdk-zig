const PivotTableFieldCollapseStateOption = @import("pivot_table_field_collapse_state_option.zig").PivotTableFieldCollapseStateOption;
const PivotTableDataPathOption = @import("pivot_table_data_path_option.zig").PivotTableDataPathOption;
const PivotTableFieldOption = @import("pivot_table_field_option.zig").PivotTableFieldOption;

/// The field options for a pivot table visual.
pub const PivotTableFieldOptions = struct {
    /// The collapse state options for the pivot table field options.
    collapse_state_options: ?[]const PivotTableFieldCollapseStateOption = null,

    /// The data path options for the pivot table field options.
    data_path_options: ?[]const PivotTableDataPathOption = null,

    /// The selected field options for the pivot table field options.
    selected_field_options: ?[]const PivotTableFieldOption = null,

    pub const json_field_names = .{
        .collapse_state_options = "CollapseStateOptions",
        .data_path_options = "DataPathOptions",
        .selected_field_options = "SelectedFieldOptions",
    };
};
