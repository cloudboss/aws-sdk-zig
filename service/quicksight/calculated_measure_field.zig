/// The table calculation measure field for pivot tables.
pub const CalculatedMeasureField = struct {
    /// The expression in the table calculation.
    expression: []const u8,

    /// The custom field ID.
    field_id: []const u8,

    pub const json_field_names = .{
        .expression = "Expression",
        .field_id = "FieldId",
    };
};
