const ItemsLimitConfiguration = @import("items_limit_configuration.zig").ItemsLimitConfiguration;
const FieldSortOptions = @import("field_sort_options.zig").FieldSortOptions;

/// The sort configuration of a heat map.
pub const HeatMapSortConfiguration = struct {
    /// The limit on the number of columns that are displayed in a heat map.
    heat_map_column_items_limit_configuration: ?ItemsLimitConfiguration,

    /// The column sort configuration for heat map for columns that aren't a part of
    /// a field well.
    heat_map_column_sort: ?[]const FieldSortOptions,

    /// The limit on the number of rows that are displayed in a heat map.
    heat_map_row_items_limit_configuration: ?ItemsLimitConfiguration,

    /// The field sort configuration of the rows fields.
    heat_map_row_sort: ?[]const FieldSortOptions,

    pub const json_field_names = .{
        .heat_map_column_items_limit_configuration = "HeatMapColumnItemsLimitConfiguration",
        .heat_map_column_sort = "HeatMapColumnSort",
        .heat_map_row_items_limit_configuration = "HeatMapRowItemsLimitConfiguration",
        .heat_map_row_sort = "HeatMapRowSort",
    };
};
