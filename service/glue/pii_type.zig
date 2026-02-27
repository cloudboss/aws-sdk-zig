pub const PiiType = enum {
    row_audit,
    row_hashing,
    row_masking,
    row_partial_masking,
    column_audit,
    column_hashing,
    column_masking,

    pub const json_field_names = .{
        .row_audit = "RowAudit",
        .row_hashing = "RowHashing",
        .row_masking = "RowMasking",
        .row_partial_masking = "RowPartialMasking",
        .column_audit = "ColumnAudit",
        .column_hashing = "ColumnHashing",
        .column_masking = "ColumnMasking",
    };
};
