const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;

/// The reference that specifies where the axis label is applied to.
pub const AxisLabelReferenceOptions = struct {
    /// The column that the axis label is targeted to.
    column: ColumnIdentifier,

    /// The field that the axis label is targeted to.
    field_id: []const u8,

    pub const json_field_names = .{
        .column = "Column",
        .field_id = "FieldId",
    };
};
