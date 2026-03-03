const PluginVisualItemsLimitConfiguration = @import("plugin_visual_items_limit_configuration.zig").PluginVisualItemsLimitConfiguration;
const FieldSortOptions = @import("field_sort_options.zig").FieldSortOptions;

/// The table query sorting options for the plugin visual.
pub const PluginVisualTableQuerySort = struct {
    /// The maximum amount of data to be returned by a query.
    items_limit_configuration: ?PluginVisualItemsLimitConfiguration = null,

    /// Determines how data is sorted in the response.
    row_sort: ?[]const FieldSortOptions = null,

    pub const json_field_names = .{
        .items_limit_configuration = "ItemsLimitConfiguration",
        .row_sort = "RowSort",
    };
};
