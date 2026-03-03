const ItemsLimitConfiguration = @import("items_limit_configuration.zig").ItemsLimitConfiguration;
const FieldSortOptions = @import("field_sort_options.zig").FieldSortOptions;

/// sort-configuration-description
pub const BarChartSortConfiguration = struct {
    /// The limit on the number of categories displayed in a bar chart.
    category_items_limit: ?ItemsLimitConfiguration = null,

    /// The sort configuration of category fields.
    category_sort: ?[]const FieldSortOptions = null,

    /// The limit on the number of values displayed in a bar chart.
    color_items_limit: ?ItemsLimitConfiguration = null,

    /// The sort configuration of color fields in a bar chart.
    color_sort: ?[]const FieldSortOptions = null,

    /// The limit on the number of small multiples panels that are displayed.
    small_multiples_limit_configuration: ?ItemsLimitConfiguration = null,

    /// The sort configuration of the small multiples field.
    small_multiples_sort: ?[]const FieldSortOptions = null,

    pub const json_field_names = .{
        .category_items_limit = "CategoryItemsLimit",
        .category_sort = "CategorySort",
        .color_items_limit = "ColorItemsLimit",
        .color_sort = "ColorSort",
        .small_multiples_limit_configuration = "SmallMultiplesLimitConfiguration",
        .small_multiples_sort = "SmallMultiplesSort",
    };
};
