const ItemsLimitConfiguration = @import("items_limit_configuration.zig").ItemsLimitConfiguration;
const FieldSortOptions = @import("field_sort_options.zig").FieldSortOptions;

/// The sort configuration of a word cloud visual.
pub const WordCloudSortConfiguration = struct {
    /// The limit on the number of groups that are displayed in a word cloud.
    category_items_limit: ?ItemsLimitConfiguration,

    /// The sort configuration of group by fields.
    category_sort: ?[]const FieldSortOptions,

    pub const json_field_names = .{
        .category_items_limit = "CategoryItemsLimit",
        .category_sort = "CategorySort",
    };
};
