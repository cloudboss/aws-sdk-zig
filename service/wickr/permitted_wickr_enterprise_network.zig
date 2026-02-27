/// Identifies a Wickr enterprise network that is permitted for global
/// federation, allowing users to communicate with members of the specified
/// network.
pub const PermittedWickrEnterpriseNetwork = struct {
    /// The domain identifier for the permitted Wickr enterprise network.
    domain: []const u8,

    /// The network ID of the permitted Wickr enterprise network.
    network_id: []const u8,

    pub const json_field_names = .{
        .domain = "domain",
        .network_id = "networkId",
    };
};
