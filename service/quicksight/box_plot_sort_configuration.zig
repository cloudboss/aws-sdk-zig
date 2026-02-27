const FieldSortOptions = @import("field_sort_options.zig").FieldSortOptions;
const PaginationConfiguration = @import("pagination_configuration.zig").PaginationConfiguration;

/// The sort configuration of a `BoxPlotVisual`.
pub const BoxPlotSortConfiguration = struct {
    /// The sort configuration of a group by fields.
    category_sort: ?[]const FieldSortOptions,

    /// The pagination configuration of a table visual or box plot.
    pagination_configuration: ?PaginationConfiguration,

    pub const json_field_names = .{
        .category_sort = "CategorySort",
        .pagination_configuration = "PaginationConfiguration",
    };
};
