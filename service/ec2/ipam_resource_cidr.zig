const IpamComplianceStatus = @import("ipam_compliance_status.zig").IpamComplianceStatus;
const IpamManagementState = @import("ipam_management_state.zig").IpamManagementState;
const IpamOverlapStatus = @import("ipam_overlap_status.zig").IpamOverlapStatus;
const IpamResourceTag = @import("ipam_resource_tag.zig").IpamResourceTag;
const IpamResourceType = @import("ipam_resource_type.zig").IpamResourceType;

/// The CIDR for an IPAM resource.
pub const IpamResourceCidr = struct {
    /// The Availability Zone ID.
    availability_zone_id: ?[]const u8,

    /// The compliance status of the IPAM resource. For more information on
    /// compliance statuses, see [Monitor CIDR usage by
    /// resource](https://docs.aws.amazon.com/vpc/latest/ipam/monitor-cidr-compliance-ipam.html) in the *Amazon VPC IPAM User Guide*.
    compliance_status: ?IpamComplianceStatus,

    /// The IPAM ID for an IPAM resource.
    ipam_id: ?[]const u8,

    /// The pool ID for an IPAM resource.
    ipam_pool_id: ?[]const u8,

    /// The scope ID for an IPAM resource.
    ipam_scope_id: ?[]const u8,

    /// The percentage of IP address space in use. To convert the decimal to a
    /// percentage, multiply the decimal by 100. Note the following:
    ///
    /// * For resources that are VPCs, this is the percentage of IP address space in
    ///   the VPC that's taken up by subnet CIDRs.
    ///
    /// * For resources that are subnets, if the subnet has an IPv4 CIDR provisioned
    ///   to it, this is the percentage of IPv4 address space in the subnet that's
    ///   in use. If the subnet has an IPv6 CIDR provisioned to it, the percentage
    ///   of IPv6 address space in use is not represented. The percentage of IPv6
    ///   address space in use cannot currently be calculated.
    ///
    /// * For resources that are public IPv4 pools, this is the percentage of IP
    ///   address space in the pool that's been allocated to Elastic IP addresses
    ///   (EIPs).
    ip_usage: ?f64,

    /// The management state of the resource. For more information about management
    /// states, see [Monitor CIDR usage by
    /// resource](https://docs.aws.amazon.com/vpc/latest/ipam/monitor-cidr-compliance-ipam.html) in the *Amazon VPC IPAM User Guide*.
    management_state: ?IpamManagementState,

    /// The overlap status of an IPAM resource. The overlap status tells you if the
    /// CIDR for a resource overlaps with another CIDR in the scope. For more
    /// information on overlap statuses, see [Monitor CIDR usage by
    /// resource](https://docs.aws.amazon.com/vpc/latest/ipam/monitor-cidr-compliance-ipam.html) in the *Amazon VPC IPAM User Guide*.
    overlap_status: ?IpamOverlapStatus,

    /// The CIDR for an IPAM resource.
    resource_cidr: ?[]const u8,

    /// The ID of an IPAM resource.
    resource_id: ?[]const u8,

    /// The name of an IPAM resource.
    resource_name: ?[]const u8,

    /// The Amazon Web Services account number of the owner of an IPAM resource.
    resource_owner_id: ?[]const u8,

    /// The Amazon Web Services Region for an IPAM resource.
    resource_region: ?[]const u8,

    /// The tags for an IPAM resource.
    resource_tags: ?[]const IpamResourceTag,

    /// The type of IPAM resource.
    resource_type: ?IpamResourceType,

    /// The ID of a VPC.
    vpc_id: ?[]const u8,
};
