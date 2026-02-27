const ItemsLimitConfiguration = @import("items_limit_configuration.zig").ItemsLimitConfiguration;
const FieldSortOptions = @import("field_sort_options.zig").FieldSortOptions;

/// The sort configuration of a sankey diagram.
pub const SankeyDiagramSortConfiguration = struct {
    /// The limit on the number of destination nodes that are displayed in a sankey
    /// diagram.
    destination_items_limit: ?ItemsLimitConfiguration,

    /// The limit on the number of source nodes that are displayed in a sankey
    /// diagram.
    source_items_limit: ?ItemsLimitConfiguration,

    /// The sort configuration of the weight fields.
    weight_sort: ?[]const FieldSortOptions,

    pub const json_field_names = .{
        .destination_items_limit = "DestinationItemsLimit",
        .source_items_limit = "SourceItemsLimit",
        .weight_sort = "WeightSort",
    };
};
