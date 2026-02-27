pub const PivotTableConditionalFormattingScopeRole = enum {
    field,
    field_total,
    grand_total,

    pub const json_field_names = .{
        .field = "FIELD",
        .field_total = "FIELD_TOTAL",
        .grand_total = "GRAND_TOTAL",
    };
};
