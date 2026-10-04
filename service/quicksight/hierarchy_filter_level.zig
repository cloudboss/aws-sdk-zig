const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;

/// One level of the drill-down path of a `HierarchyFilter`.
pub const HierarchyFilterLevel = struct {
    /// The column that this level of the hierarchy drills down by. This column must
    /// belong to
    /// the same dataset as `HierarchyFilter$Column`.
    column: ColumnIdentifier,

    pub const json_field_names = .{
        .column = "Column",
    };
};
