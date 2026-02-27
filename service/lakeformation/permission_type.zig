pub const PermissionType = enum {
    column_permission,
    cell_filter_permission,
    nested_permission,
    nested_cell_permission,

    pub const json_field_names = .{
        .column_permission = "COLUMN_PERMISSION",
        .cell_filter_permission = "CELL_FILTER_PERMISSION",
        .nested_permission = "NESTED_PERMISSION",
        .nested_cell_permission = "NESTED_CELL_PERMISSION",
    };
};
