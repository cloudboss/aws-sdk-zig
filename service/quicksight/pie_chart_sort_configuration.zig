const ItemsLimitConfiguration = @import("items_limit_configuration.zig").ItemsLimitConfiguration;
const FieldSortOptions = @import("field_sort_options.zig").FieldSortOptions;

/// The sort configuration of a pie chart.
pub const PieChartSortConfiguration = struct {
    /// The limit on the number of categories that are displayed in a pie chart.
    category_items_limit: ?ItemsLimitConfiguration,

    /// The sort configuration of the category fields.
    category_sort: ?[]const FieldSortOptions,

    /// The limit on the number of small multiples panels that are displayed.
    small_multiples_limit_configuration: ?ItemsLimitConfiguration,

    /// The sort configuration of the small multiples field.
    small_multiples_sort: ?[]const FieldSortOptions,

    pub const json_field_names = .{
        .category_items_limit = "CategoryItemsLimit",
        .category_sort = "CategorySort",
        .small_multiples_limit_configuration = "SmallMultiplesLimitConfiguration",
        .small_multiples_sort = "SmallMultiplesSort",
    };
};
