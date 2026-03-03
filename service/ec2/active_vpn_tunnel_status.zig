const VpnTunnelProvisioningStatus = @import("vpn_tunnel_provisioning_status.zig").VpnTunnelProvisioningStatus;

/// Contains information about the current security configuration of an active
/// VPN tunnel.
pub const ActiveVpnTunnelStatus = struct {
    /// The version of the Internet Key Exchange (IKE) protocol being used.
    ike_version: ?[]const u8 = null,

    /// The Diffie-Hellman group number being used in Phase 1 IKE negotiations.
    phase_1_dh_group: ?i32 = null,

    /// The encryption algorithm negotiated in Phase 1 IKE negotiations.
    phase_1_encryption_algorithm: ?[]const u8 = null,

    /// The integrity algorithm negotiated in Phase 1 IKE negotiations.
    phase_1_integrity_algorithm: ?[]const u8 = null,

    /// The Diffie-Hellman group number being used in Phase 2 IKE negotiations.
    phase_2_dh_group: ?i32 = null,

    /// The encryption algorithm negotiated in Phase 2 IKE negotiations.
    phase_2_encryption_algorithm: ?[]const u8 = null,

    /// The integrity algorithm negotiated in Phase 2 IKE negotiations.
    phase_2_integrity_algorithm: ?[]const u8 = null,

    /// The current provisioning status of the VPN tunnel.
    provisioning_status: ?VpnTunnelProvisioningStatus = null,

    /// The reason for the current provisioning status.
    provisioning_status_reason: ?[]const u8 = null,
};
