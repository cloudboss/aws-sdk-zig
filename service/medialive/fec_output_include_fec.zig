/// Fec Output Include Fec
pub const FecOutputIncludeFec = enum {
    column,
    column_and_row,

    pub const json_field_names = .{
        .column = "COLUMN",
        .column_and_row = "COLUMN_AND_ROW",
    };
};
