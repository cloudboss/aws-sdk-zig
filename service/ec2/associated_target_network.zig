const AssociatedNetworkType = @import("associated_network_type.zig").AssociatedNetworkType;

/// Describes a target network that is associated with a Client VPN endpoint. A
/// target network is a subnet in a VPC.
pub const AssociatedTargetNetwork = struct {
    /// The ID of the subnet.
    network_id: ?[]const u8 = null,

    /// The target network type.
    network_type: ?AssociatedNetworkType = null,
};
