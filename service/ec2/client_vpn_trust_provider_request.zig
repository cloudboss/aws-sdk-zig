const ClientVpnDeviceTrustProviderType = @import("client_vpn_device_trust_provider_type.zig").ClientVpnDeviceTrustProviderType;

/// Describes a device trust provider to configure for a Client VPN endpoint.
pub const ClientVpnTrustProviderRequest = struct {
    /// The URL of the public signing key that is used to verify the identity token
    /// issued by the device trust provider.
    public_signing_key_url: ?[]const u8 = null,

    /// The tenant ID associated with your device trust provider account.
    tenant_id: ?[]const u8 = null,

    /// The type of the device trust provider. Possible values include:
    ///
    /// * `crowdstrike` - CrowdStrike device trust provider.
    ///
    /// * `jamf` - Jamf device trust provider.
    ///
    /// * `jumpcloud` - JumpCloud device trust provider.
    trust_provider_type: ?ClientVpnDeviceTrustProviderType = null,
};
