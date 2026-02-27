const PaginationConfiguration = @import("pagination_configuration.zig").PaginationConfiguration;
const FieldSortOptions = @import("field_sort_options.zig").FieldSortOptions;

/// The sort configuration for a `TableVisual`.
pub const TableSortConfiguration = struct {
    /// The pagination configuration (page size, page number) for the table.
    pagination_configuration: ?PaginationConfiguration,

    /// The field sort options for rows in the table.
    row_sort: ?[]const FieldSortOptions,

    pub const json_field_names = .{
        .pagination_configuration = "PaginationConfiguration",
        .row_sort = "RowSort",
    };
};
