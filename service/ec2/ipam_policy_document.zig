const IpamPolicyAllocationRule = @import("ipam_policy_allocation_rule.zig").IpamPolicyAllocationRule;
const IpamPolicyResourceType = @import("ipam_policy_resource_type.zig").IpamPolicyResourceType;

/// Information about an IPAM policy.
pub const IpamPolicyDocument = struct {
    /// The allocation rules in the IPAM policy document.
    ///
    /// Allocation rules are optional configurations within an IPAM policy that map
    /// Amazon Web Services resource types to specific IPAM pools. If no rules are
    /// defined, the resource types default to using Amazon-provided IP addresses.
    allocation_rules: ?[]const IpamPolicyAllocationRule,

    /// The ID of the IPAM policy.
    ipam_policy_id: ?[]const u8,

    /// The locale of the IPAM policy document.
    locale: ?[]const u8,

    /// The resource type of the IPAM policy document.
    ///
    /// The Amazon Web Services service or resource type that can use IP addresses
    /// through IPAM policies. Supported services and resource types include:
    ///
    /// * Elastic IP addresses
    resource_type: ?IpamPolicyResourceType,
};
