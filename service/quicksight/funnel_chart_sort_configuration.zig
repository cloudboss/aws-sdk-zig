const ItemsLimitConfiguration = @import("items_limit_configuration.zig").ItemsLimitConfiguration;
const FieldSortOptions = @import("field_sort_options.zig").FieldSortOptions;

/// The sort configuration of a `FunnelChartVisual`.
pub const FunnelChartSortConfiguration = struct {
    /// The limit on the number of categories displayed.
    category_items_limit: ?ItemsLimitConfiguration = null,

    /// The sort configuration of the category fields.
    category_sort: ?[]const FieldSortOptions = null,

    pub const json_field_names = .{
        .category_items_limit = "CategoryItemsLimit",
        .category_sort = "CategorySort",
    };
};
