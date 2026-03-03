/// The optional configuration of subtotals cells.
pub const PivotTableFieldSubtotalOptions = struct {
    /// The field ID of the subtotal options.
    field_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .field_id = "FieldId",
    };
};
