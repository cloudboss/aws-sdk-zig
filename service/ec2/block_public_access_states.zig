const BlockPublicAccessMode = @import("block_public_access_mode.zig").BlockPublicAccessMode;

/// The state of VPC Block Public Access (BPA).
pub const BlockPublicAccessStates = struct {
    /// The mode of VPC BPA.
    ///
    /// * `off`: VPC BPA is not enabled and traffic is allowed to and from internet
    ///   gateways and egress-only internet gateways in this Region.
    ///
    /// * `block-bidirectional`: Block all traffic to and from internet gateways and
    ///   egress-only internet gateways in this Region (except for excluded VPCs and
    ///   subnets).
    ///
    /// * `block-ingress`: Block all internet traffic to the VPCs in this Region
    ///   (except for VPCs or subnets which are excluded). Only traffic to and from
    ///   NAT gateways and egress-only internet gateways is allowed because these
    ///   gateways only allow outbound connections to be established.
    internet_gateway_block_mode: ?BlockPublicAccessMode,
};
