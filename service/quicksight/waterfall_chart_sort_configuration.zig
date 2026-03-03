const ItemsLimitConfiguration = @import("items_limit_configuration.zig").ItemsLimitConfiguration;
const FieldSortOptions = @import("field_sort_options.zig").FieldSortOptions;

/// The sort configuration of a waterfall visual.
pub const WaterfallChartSortConfiguration = struct {
    /// The limit on the number of bar groups that are displayed.
    breakdown_items_limit: ?ItemsLimitConfiguration = null,

    /// The sort configuration of the category fields.
    category_sort: ?[]const FieldSortOptions = null,

    pub const json_field_names = .{
        .breakdown_items_limit = "BreakdownItemsLimit",
        .category_sort = "CategorySort",
    };
};
