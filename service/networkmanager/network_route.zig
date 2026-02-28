const NetworkRouteDestination = @import("network_route_destination.zig").NetworkRouteDestination;
const RouteState = @import("route_state.zig").RouteState;
const RouteType = @import("route_type.zig").RouteType;

/// Describes a network route.
pub const NetworkRoute = struct {
    /// A unique identifier for the route, such as a CIDR block.
    destination_cidr_block: ?[]const u8,

    /// The destinations.
    destinations: ?[]const NetworkRouteDestination,

    /// The ID of the prefix list.
    prefix_list_id: ?[]const u8,

    /// The route state. The possible values are `active` and `blackhole`.
    state: ?RouteState,

    /// The route type. The possible values are `propagated` and `static`.
    @"type": ?RouteType,

    pub const json_field_names = .{
        .destination_cidr_block = "DestinationCidrBlock",
        .destinations = "Destinations",
        .prefix_list_id = "PrefixListId",
        .state = "State",
        .@"type" = "Type",
    };
};
