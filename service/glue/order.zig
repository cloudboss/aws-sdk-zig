/// Specifies the sort order of a sorted column.
pub const Order = struct {
    /// The name of the column.
    column: []const u8,

    /// Indicates that the column is sorted in ascending order
    /// (`== 1`), or in descending order (`==0`).
    sort_order: i32 = 0,

    pub const json_field_names = .{
        .column = "Column",
        .sort_order = "SortOrder",
    };
};
