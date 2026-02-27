pub const PivotTableMetricPlacement = enum {
    row,
    column,

    pub const json_field_names = .{
        .row = "ROW",
        .column = "COLUMN",
    };
};
