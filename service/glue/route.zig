const GroupFilters = @import("group_filters.zig").GroupFilters;

/// Specifies a route node that directs data to different output paths based on
/// defined filtering conditions.
pub const Route = struct {
    /// A list of group filters that define the routing conditions and criteria for
    /// directing data to different output paths.
    group_filters_list: []const GroupFilters,

    /// The input connection for the route node.
    inputs: []const []const u8,

    /// The name of the route node.
    name: []const u8,

    pub const json_field_names = .{
        .group_filters_list = "GroupFiltersList",
        .inputs = "Inputs",
        .name = "Name",
    };
};
