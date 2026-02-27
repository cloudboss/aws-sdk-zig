const RouterInputType = @import("router_input_type.zig").RouterInputType;
const RoutingScope = @import("routing_scope.zig").RoutingScope;

/// A filter that can be used to retrieve a list of router inputs.
pub const RouterInputFilter = union(enum) {
    /// The types of router inputs to include in the filter.
    input_types: ?[]const RouterInputType,
    /// The names of the router inputs to include in the filter.
    name_contains: ?[]const []const u8,
    /// The Amazon Resource Names (ARNs) of the network interfaces associated with
    /// the router inputs to include in the filter.
    network_interface_arns: ?[]const []const u8,
    /// The AWS Regions of the router inputs to include in the filter.
    region_names: ?[]const []const u8,
    /// Filter criteria to list router inputs based on their routing scope (REGIONAL
    /// or GLOBAL).
    routing_scopes: ?[]const RoutingScope,

    pub const json_field_names = .{
        .input_types = "InputTypes",
        .name_contains = "NameContains",
        .network_interface_arns = "NetworkInterfaceArns",
        .region_names = "RegionNames",
        .routing_scopes = "RoutingScopes",
    };
};
