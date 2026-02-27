const ItemsLimitConfiguration = @import("items_limit_configuration.zig").ItemsLimitConfiguration;
const FieldSortOptions = @import("field_sort_options.zig").FieldSortOptions;

/// The sort configuration of a tree map.
pub const TreeMapSortConfiguration = struct {
    /// The limit on the number of groups that are displayed.
    tree_map_group_items_limit_configuration: ?ItemsLimitConfiguration,

    /// The sort configuration of group by fields.
    tree_map_sort: ?[]const FieldSortOptions,

    pub const json_field_names = .{
        .tree_map_group_items_limit_configuration = "TreeMapGroupItemsLimitConfiguration",
        .tree_map_sort = "TreeMapSort",
    };
};
