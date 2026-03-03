const ItemsLimitConfiguration = @import("items_limit_configuration.zig").ItemsLimitConfiguration;
const FieldSortOptions = @import("field_sort_options.zig").FieldSortOptions;

/// The sort configuration of a `ComboChartVisual`.
pub const ComboChartSortConfiguration = struct {
    /// The item limit configuration for the category field well of a combo chart.
    category_items_limit: ?ItemsLimitConfiguration = null,

    /// The sort configuration of the category field well in a combo chart.
    category_sort: ?[]const FieldSortOptions = null,

    /// The item limit configuration of the color field well in a combo chart.
    color_items_limit: ?ItemsLimitConfiguration = null,

    /// The sort configuration of the color field well in a combo chart.
    color_sort: ?[]const FieldSortOptions = null,

    pub const json_field_names = .{
        .category_items_limit = "CategoryItemsLimit",
        .category_sort = "CategorySort",
        .color_items_limit = "ColorItemsLimit",
        .color_sort = "ColorSort",
    };
};
