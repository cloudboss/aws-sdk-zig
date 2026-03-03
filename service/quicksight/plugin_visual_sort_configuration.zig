const PluginVisualTableQuerySort = @import("plugin_visual_table_query_sort.zig").PluginVisualTableQuerySort;

/// Determines how the plugin visual sorts the data during query.
pub const PluginVisualSortConfiguration = struct {
    /// The table query sorting options for the plugin visual.
    plugin_visual_table_query_sort: ?PluginVisualTableQuerySort = null,

    pub const json_field_names = .{
        .plugin_visual_table_query_sort = "PluginVisualTableQuerySort",
    };
};
