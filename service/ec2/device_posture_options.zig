const ClientVpnTrustProviderRequest = @import("client_vpn_trust_provider_request.zig").ClientVpnTrustProviderRequest;

/// Describes the device posture options for a Client VPN endpoint. Device
/// posture options specify the device trust providers that the endpoint uses to
/// evaluate the security posture of connecting devices.
pub const DevicePostureOptions = struct {
    /// Indicates whether device posture evaluation is enabled for the Client VPN
    /// endpoint. Specify `false` to disable device posture, which clears the
    /// configured device trust providers.
    enabled: ?bool = null,

    /// The device trust providers to configure for the Client VPN endpoint.
    trust_providers: ?[]const ClientVpnTrustProviderRequest = null,
};
