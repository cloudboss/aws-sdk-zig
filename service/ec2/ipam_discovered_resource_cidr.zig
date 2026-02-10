const IpamResourceCidrIpSource = @import("ipam_resource_cidr_ip_source.zig").IpamResourceCidrIpSource;
const IpamNetworkInterfaceAttachmentStatus = @import("ipam_network_interface_attachment_status.zig").IpamNetworkInterfaceAttachmentStatus;
const IpamResourceTag = @import("ipam_resource_tag.zig").IpamResourceTag;
const IpamResourceType = @import("ipam_resource_type.zig").IpamResourceType;

/// An IPAM discovered resource CIDR. A discovered resource is a resource CIDR
/// monitored under a resource discovery. The following resources can be
/// discovered: VPCs, Public IPv4 pools, VPC subnets, and Elastic IP addresses.
/// The discovered resource CIDR is the IP address range in CIDR notation that
/// is associated with the resource.
pub const IpamDiscoveredResourceCidr = struct {
    /// The Availability Zone ID.
    availability_zone_id: ?[]const u8,

    /// The resource discovery ID.
    ipam_resource_discovery_id: ?[]const u8,

    /// The source that allocated the IP address space. `byoip` or `amazon`
    /// indicates public IP address space allocated by Amazon or space that you have
    /// allocated with Bring your own IP (BYOIP). `none` indicates private space.
    ip_source: ?IpamResourceCidrIpSource,

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

    /// For elastic network interfaces, this is the status of whether or not the
    /// elastic network interface is attached.
    network_interface_attachment_status: ?IpamNetworkInterfaceAttachmentStatus,

    /// The resource CIDR.
    resource_cidr: ?[]const u8,

    /// The resource ID.
    resource_id: ?[]const u8,

    /// The resource owner ID.
    resource_owner_id: ?[]const u8,

    /// The resource Region.
    resource_region: ?[]const u8,

    /// The resource tags.
    resource_tags: ?[]const IpamResourceTag,

    /// The resource type.
    resource_type: ?IpamResourceType,

    /// The last successful resource discovery time.
    sample_time: ?i64,

    /// The subnet ID.
    subnet_id: ?[]const u8,

    /// The VPC ID.
    vpc_id: ?[]const u8,
};
