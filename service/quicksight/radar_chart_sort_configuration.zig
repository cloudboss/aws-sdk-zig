const ItemsLimitConfiguration = @import("items_limit_configuration.zig").ItemsLimitConfiguration;
const FieldSortOptions = @import("field_sort_options.zig").FieldSortOptions;

/// The sort configuration of a `RadarChartVisual`.
pub const RadarChartSortConfiguration = struct {
    /// The category items limit for a radar chart.
    category_items_limit: ?ItemsLimitConfiguration = null,

    /// The category sort options of a radar chart.
    category_sort: ?[]const FieldSortOptions = null,

    /// The color items limit of a radar chart.
    color_items_limit: ?ItemsLimitConfiguration = null,

    /// The color sort configuration of a radar chart.
    color_sort: ?[]const FieldSortOptions = null,

    pub const json_field_names = .{
        .category_items_limit = "CategoryItemsLimit",
        .category_sort = "CategorySort",
        .color_items_limit = "ColorItemsLimit",
        .color_sort = "ColorSort",
    };
};
