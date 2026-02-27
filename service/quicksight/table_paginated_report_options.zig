const Visibility = @import("visibility.zig").Visibility;

/// The paginated report options for a table visual.
pub const TablePaginatedReportOptions = struct {
    /// The visibility of repeating header rows on each page.
    overflow_column_header_visibility: ?Visibility,

    /// The visibility of printing table overflow across pages.
    vertical_overflow_visibility: ?Visibility,

    pub const json_field_names = .{
        .overflow_column_header_visibility = "OverflowColumnHeaderVisibility",
        .vertical_overflow_visibility = "VerticalOverflowVisibility",
    };
};
