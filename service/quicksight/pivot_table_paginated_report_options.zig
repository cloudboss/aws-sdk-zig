const Visibility = @import("visibility.zig").Visibility;

/// The paginated report options for a pivot table visual.
pub const PivotTablePaginatedReportOptions = struct {
    /// The visibility of the repeating header rows on each page.
    overflow_column_header_visibility: ?Visibility = null,

    /// The visibility of the printing table overflow across pages.
    vertical_overflow_visibility: ?Visibility = null,

    pub const json_field_names = .{
        .overflow_column_header_visibility = "OverflowColumnHeaderVisibility",
        .vertical_overflow_visibility = "VerticalOverflowVisibility",
    };
};
