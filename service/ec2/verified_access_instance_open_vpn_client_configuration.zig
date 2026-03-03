const VerifiedAccessInstanceOpenVpnClientConfigurationRoute = @import("verified_access_instance_open_vpn_client_configuration_route.zig").VerifiedAccessInstanceOpenVpnClientConfigurationRoute;

/// Describes a set of routes.
pub const VerifiedAccessInstanceOpenVpnClientConfiguration = struct {
    /// The base64-encoded Open VPN client configuration.
    config: ?[]const u8 = null,

    /// The routes.
    routes: ?[]const VerifiedAccessInstanceOpenVpnClientConfigurationRoute = null,
};
