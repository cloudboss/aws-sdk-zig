const aws = @import("aws");

const GraphDisplayConfig = @import("graph_display_config.zig").GraphDisplayConfig;
const TableDisplayConfigStruct = @import("table_display_config_struct.zig").TableDisplayConfigStruct;

/// Defines how the widget's data should be visualized, including chart type,
/// color schemes, axis configurations, and other display preferences.
pub const DisplayConfig = union(enum) {
    /// The configuration for graphical display of the widget data, including chart
    /// type and visual options.
    graph: ?[]const aws.map.MapEntry(GraphDisplayConfig),
    /// The configuration for tabular display of the widget data.
    table: ?TableDisplayConfigStruct,

    pub const json_field_names = .{
        .graph = "graph",
        .table = "table",
    };
};
