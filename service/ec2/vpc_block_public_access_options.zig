const VpcBlockPublicAccessExclusionsAllowed = @import("vpc_block_public_access_exclusions_allowed.zig").VpcBlockPublicAccessExclusionsAllowed;
const InternetGatewayBlockMode = @import("internet_gateway_block_mode.zig").InternetGatewayBlockMode;
const ManagedBy = @import("managed_by.zig").ManagedBy;
const VpcBlockPublicAccessState = @import("vpc_block_public_access_state.zig").VpcBlockPublicAccessState;

/// VPC Block Public Access (BPA) enables you to block resources in VPCs and
/// subnets that you own in a Region from reaching or being reached from the
/// internet through internet gateways and egress-only internet gateways. To
/// learn more about VPC BPA, see [Block public access to VPCs and
/// subnets](https://docs.aws.amazon.com/vpc/latest/userguide/security-vpc-bpa.html) in the *Amazon VPC User Guide*.
pub const VpcBlockPublicAccessOptions = struct {
    /// An Amazon Web Services account ID.
    aws_account_id: ?[]const u8 = null,

    /// An Amazon Web Services Region.
    aws_region: ?[]const u8 = null,

    /// Determines if exclusions are allowed. If you have [enabled VPC BPA at the
    /// Organization
    /// level](https://docs.aws.amazon.com/vpc/latest/userguide/security-vpc-bpa.html#security-vpc-bpa-exclusions-orgs), exclusions may be
    /// `not-allowed`. Otherwise, they are `allowed`.
    exclusions_allowed: ?VpcBlockPublicAccessExclusionsAllowed = null,

    /// The current mode of VPC BPA.
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
    internet_gateway_block_mode: ?InternetGatewayBlockMode = null,

    /// The last time the VPC BPA mode was updated.
    last_update_timestamp: ?i64 = null,

    /// The entity that manages the state of VPC BPA. Possible values include:
    ///
    /// * `account` - The state is managed by the account.
    ///
    /// * `declarative-policy` - The state is managed by a declarative policy
    /// and can't be modified by the account.
    managed_by: ?ManagedBy = null,

    /// The reason for the current state.
    reason: ?[]const u8 = null,

    /// The current state of VPC BPA.
    state: ?VpcBlockPublicAccessState = null,
};
