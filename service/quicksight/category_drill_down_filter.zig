const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;

/// The category drill down filter.
pub const CategoryDrillDownFilter = struct {
    /// A list of the string inputs that are the values of the category drill down
    /// filter.
    category_values: []const []const u8,

    /// The column that the filter is applied to.
    column: ColumnIdentifier,

    pub const json_field_names = .{
        .category_values = "CategoryValues",
        .column = "Column",
    };
};
