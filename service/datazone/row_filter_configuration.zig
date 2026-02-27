const RowFilter = @import("row_filter.zig").RowFilter;

/// The row filter configuration details.
pub const RowFilterConfiguration = struct {
    /// The row filter.
    row_filter: RowFilter,

    /// Specifies whether the row filter is sensitive.
    sensitive: bool = true,

    pub const json_field_names = .{
        .row_filter = "rowFilter",
        .sensitive = "sensitive",
    };
};
