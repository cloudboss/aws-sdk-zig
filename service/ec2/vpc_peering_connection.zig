const VpcPeeringConnectionVpcInfo = @import("vpc_peering_connection_vpc_info.zig").VpcPeeringConnectionVpcInfo;
const VpcPeeringConnectionStateReason = @import("vpc_peering_connection_state_reason.zig").VpcPeeringConnectionStateReason;
const Tag = @import("tag.zig").Tag;

/// Describes a VPC peering connection.
pub const VpcPeeringConnection = struct {
    /// Information about the accepter VPC. CIDR block information is only returned
    /// when describing an active VPC peering connection.
    accepter_vpc_info: ?VpcPeeringConnectionVpcInfo = null,

    /// The time that an unaccepted VPC peering connection will expire.
    expiration_time: ?i64 = null,

    /// Information about the requester VPC. CIDR block information is only returned
    /// when describing an active VPC peering connection.
    requester_vpc_info: ?VpcPeeringConnectionVpcInfo = null,

    /// The status of the VPC peering connection.
    status: ?VpcPeeringConnectionStateReason = null,

    /// Any tags assigned to the resource.
    tags: ?[]const Tag = null,

    /// The ID of the VPC peering connection.
    vpc_peering_connection_id: ?[]const u8 = null,
};
