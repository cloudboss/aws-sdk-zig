/// The connectivity configuration for the environment. Amazon EVS requires that
/// you specify two route server peer IDs. During environment creation, the
/// route server endpoints peer with the NSX uplink VLAN for connectivity to the
/// NSX overlay network.
pub const ConnectivityInfo = struct {
    /// The unique IDs for private route server peers.
    private_route_server_peerings: []const []const u8,

    pub const json_field_names = .{
        .private_route_server_peerings = "privateRouteServerPeerings",
    };
};
