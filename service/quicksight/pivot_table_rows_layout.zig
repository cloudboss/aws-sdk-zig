pub const PivotTableRowsLayout = enum {
    tabular,
    hierarchy,

    pub const json_field_names = .{
        .tabular = "TABULAR",
        .hierarchy = "HIERARCHY",
    };
};
