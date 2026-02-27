const RouterOutputType = @import("router_output_type.zig").RouterOutputType;
const RoutingScope = @import("routing_scope.zig").RoutingScope;

/// A filter that can be used to retrieve a list of router outputs.
pub const RouterOutputFilter = union(enum) {
    /// The names of the router outputs to include in the filter.
    name_contains: ?[]const []const u8,
    /// The Amazon Resource Names (ARNs) of the network interfaces associated with
    /// the router outputs to include in the filter.
    network_interface_arns: ?[]const []const u8,
    /// The types of router outputs to include in the filter.
    output_types: ?[]const RouterOutputType,
    /// The AWS Regions of the router outputs to include in the filter.
    region_names: ?[]const []const u8,
    /// The ARNs of the router inputs associated with the router outputs to include
    /// in the filter.
    routed_input_arns: ?[]const []const u8,
    /// Filter criteria to list router outputs based on their routing scope.
    routing_scopes: ?[]const RoutingScope,

    pub const json_field_names = .{
        .name_contains = "NameContains",
        .network_interface_arns = "NetworkInterfaceArns",
        .output_types = "OutputTypes",
        .region_names = "RegionNames",
        .routed_input_arns = "RoutedInputArns",
        .routing_scopes = "RoutingScopes",
    };
};
