const RoutingInformationNextHop = @import("routing_information_next_hop.zig").RoutingInformationNextHop;

/// Routing information for a core network, including route details and BGP
/// attributes.
pub const CoreNetworkRoutingInformation = struct {
    /// The BGP AS path for the route.
    as_path: ?[]const []const u8 = null,

    /// The BGP community values for the route.
    communities: ?[]const []const u8 = null,

    /// The BGP local preference value for the route.
    local_preference: ?[]const u8 = null,

    /// The BGP Multi-Exit Discriminator (MED) value for the route.
    med: ?[]const u8 = null,

    /// The next hop information for the route.
    next_hop: ?RoutingInformationNextHop = null,

    /// The IP prefix for the route.
    prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .as_path = "AsPath",
        .communities = "Communities",
        .local_preference = "LocalPreference",
        .med = "Med",
        .next_hop = "NextHop",
        .prefix = "Prefix",
    };
};
