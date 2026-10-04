const ClientVpnTrustProvider = @import("client_vpn_trust_provider.zig").ClientVpnTrustProvider;

/// Information about the device posture options for a Client VPN endpoint.
pub const DevicePostureResponseOptions = struct {
    /// The device trust providers configured for the Client VPN endpoint.
    trust_providers: ?[]const ClientVpnTrustProvider = null,
};
