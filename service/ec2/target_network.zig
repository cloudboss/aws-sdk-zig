const AssociationStatus = @import("association_status.zig").AssociationStatus;

/// Describes a target network associated with a Client VPN endpoint.
pub const TargetNetwork = struct {
    /// The ID of the association.
    association_id: ?[]const u8 = null,

    /// The ID of the Client VPN endpoint with which the target network is
    /// associated.
    client_vpn_endpoint_id: ?[]const u8 = null,

    /// The IDs of the security groups applied to the target network association.
    security_groups: ?[]const []const u8 = null,

    /// The current state of the target network association.
    status: ?AssociationStatus = null,

    /// The ID of the subnet specified as the target network.
    target_network_id: ?[]const u8 = null,

    /// The ID of the VPC in which the target network (subnet) is located.
    vpc_id: ?[]const u8 = null,
};
