const VpcPeeringConnectionStateReasonCode = @import("vpc_peering_connection_state_reason_code.zig").VpcPeeringConnectionStateReasonCode;

/// Describes the status of a VPC peering connection.
pub const VpcPeeringConnectionStateReason = struct {
    /// The status of the VPC peering connection.
    code: ?VpcPeeringConnectionStateReasonCode,

    /// A message that provides more information about the status, if applicable.
    message: ?[]const u8,
};
