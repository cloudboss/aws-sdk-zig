/// Specifies the configuration settings for individual NDI® discovery servers.
/// A maximum of 3 servers is allowed.
pub const NdiDiscoveryServerConfig = struct {
    /// The unique network address of the NDI discovery server.
    discovery_server_address: []const u8,

    /// The port for the NDI discovery server. Defaults to 5959 if a custom port
    /// isn't specified.
    discovery_server_port: ?i32 = null,

    /// The identifier for the Virtual Private Cloud (VPC) network interface used by
    /// the flow.
    vpc_interface_adapter: []const u8,

    pub const json_field_names = .{
        .discovery_server_address = "DiscoveryServerAddress",
        .discovery_server_port = "DiscoveryServerPort",
        .vpc_interface_adapter = "VpcInterfaceAdapter",
    };
};
