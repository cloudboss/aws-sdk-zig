const ItemsLimitConfiguration = @import("items_limit_configuration.zig").ItemsLimitConfiguration;
const FieldSortOptions = @import("field_sort_options.zig").FieldSortOptions;

/// The sort configuration of a line chart.
pub const LineChartSortConfiguration = struct {
    /// The limit on the number of categories that are displayed in a line chart.
    category_items_limit_configuration: ?ItemsLimitConfiguration = null,

    /// The sort configuration of the category fields.
    category_sort: ?[]const FieldSortOptions = null,

    /// The limit on the number of lines that are displayed in a line chart.
    color_items_limit_configuration: ?ItemsLimitConfiguration = null,

    /// The limit on the number of small multiples panels that are displayed.
    small_multiples_limit_configuration: ?ItemsLimitConfiguration = null,

    /// The sort configuration of the small multiples field.
    small_multiples_sort: ?[]const FieldSortOptions = null,

    pub const json_field_names = .{
        .category_items_limit_configuration = "CategoryItemsLimitConfiguration",
        .category_sort = "CategorySort",
        .color_items_limit_configuration = "ColorItemsLimitConfiguration",
        .small_multiples_limit_configuration = "SmallMultiplesLimitConfiguration",
        .small_multiples_sort = "SmallMultiplesSort",
    };
};
