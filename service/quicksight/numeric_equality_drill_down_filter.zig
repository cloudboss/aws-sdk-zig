const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;

/// The numeric equality type drill down filter.
pub const NumericEqualityDrillDownFilter = struct {
    /// The column that the filter is applied to.
    column: ColumnIdentifier,

    /// The value of the double input numeric drill down filter.
    value: f64 = 0,

    pub const json_field_names = .{
        .column = "Column",
        .value = "Value",
    };
};
