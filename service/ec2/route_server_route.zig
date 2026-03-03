const RouteServerRouteInstallationDetail = @import("route_server_route_installation_detail.zig").RouteServerRouteInstallationDetail;
const RouteServerRouteStatus = @import("route_server_route_status.zig").RouteServerRouteStatus;

/// Describes a route in the route server's routing database.
pub const RouteServerRoute = struct {
    /// The AS path attributes of the BGP route.
    as_paths: ?[]const []const u8 = null,

    /// The Multi-Exit Discriminator (MED) value of the BGP route.
    med: ?i32 = null,

    /// The IP address for the next hop.
    next_hop_ip: ?[]const u8 = null,

    /// The destination CIDR block of the route.
    prefix: ?[]const u8 = null,

    /// Details about the installation status of this route in route tables.
    route_installation_details: ?[]const RouteServerRouteInstallationDetail = null,

    /// The ID of the route server endpoint that received this route.
    route_server_endpoint_id: ?[]const u8 = null,

    /// The ID of the route server peer that advertised this route.
    route_server_peer_id: ?[]const u8 = null,

    /// The current status of the route in the routing database. Values are `in-rib`
    /// or `in-fib` depending on if the routes are in the RIB or the FIB database.
    ///
    /// The [Routing Information Base
    /// (RIB)](https://en.wikipedia.org/wiki/Routing_table) serves as a database
    /// that stores all the routing information and network topology data collected
    /// by a router or routing system, such as routes learned from BGP peers. The
    /// RIB is constantly updated as new routing information is received or existing
    /// routes change. This ensures that the route server always has the most
    /// current view of the network topology and can make optimal routing decisions.
    ///
    /// The [Forwarding Information Base
    /// (FIB)](https://en.wikipedia.org/wiki/Forwarding_information_base) serves as
    /// a forwarding table for what route server has determined are the best-path
    /// routes in the RIB after evaluating all available routing information and
    /// policies. The FIB routes are installed on the route tables. The FIB is
    /// recomputed whenever there are changes to the RIB.
    route_status: ?RouteServerRouteStatus = null,
};
