const IpamPolicyState = @import("ipam_policy_state.zig").IpamPolicyState;
const Tag = @import("tag.zig").Tag;

/// Information about an IPAM policy.
///
/// An IPAM policy is a set of rules that define how public IPv4 addresses from
/// IPAM pools are allocated to Amazon Web Services resources. Each rule maps an
/// Amazon Web Services service to IPAM pools that the service will use to get
/// IP addresses. A single policy can have multiple rules and be applied to
/// multiple Amazon Web Services Regions. If the IPAM pool run out of addresses
/// then the services fallback to Amazon-provided IP addresses. A policy can be
/// applied to an individual Amazon Web Services account or an entity within
/// Amazon Web Services Organizations.
pub const IpamPolicy = struct {
    /// The ID of the IPAM this policy belongs to.
    ipam_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the IPAM policy.
    ipam_policy_arn: ?[]const u8,

    /// The ID of the IPAM policy.
    ipam_policy_id: ?[]const u8,

    /// The Region of the IPAM policy.
    ipam_policy_region: ?[]const u8,

    /// The account ID that owns the IPAM policy.
    owner_id: ?[]const u8,

    /// The state of the IPAM policy.
    state: ?IpamPolicyState,

    /// A message about the state of the IPAM policy.
    state_message: ?[]const u8,

    /// The tags assigned to the IPAM policy.
    tags: ?[]const Tag,
};
