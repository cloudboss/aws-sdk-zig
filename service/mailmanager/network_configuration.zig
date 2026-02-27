const PrivateNetworkConfiguration = @import("private_network_configuration.zig").PrivateNetworkConfiguration;
const PublicNetworkConfiguration = @import("public_network_configuration.zig").PublicNetworkConfiguration;

/// The network type (IPv4-only, Dual-Stack, PrivateLink) of the ingress
/// endpoint resource.
pub const NetworkConfiguration = union(enum) {
    /// Specifies the network configuration for the private ingress point.
    private_network_configuration: ?PrivateNetworkConfiguration,
    /// Specifies the network configuration for the public ingress point.
    public_network_configuration: ?PublicNetworkConfiguration,

    pub const json_field_names = .{
        .private_network_configuration = "PrivateNetworkConfiguration",
        .public_network_configuration = "PublicNetworkConfiguration",
    };
};
