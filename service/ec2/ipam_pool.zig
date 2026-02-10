const AddressFamily = @import("address_family.zig").AddressFamily;
const IpamResourceTag = @import("ipam_resource_tag.zig").IpamResourceTag;
const IpamPoolAwsService = @import("ipam_pool_aws_service.zig").IpamPoolAwsService;
const IpamScopeType = @import("ipam_scope_type.zig").IpamScopeType;
const IpamPoolPublicIpSource = @import("ipam_pool_public_ip_source.zig").IpamPoolPublicIpSource;
const IpamPoolSourceResource = @import("ipam_pool_source_resource.zig").IpamPoolSourceResource;
const IpamPoolState = @import("ipam_pool_state.zig").IpamPoolState;
const Tag = @import("tag.zig").Tag;

/// In IPAM, a pool is a collection of contiguous IP addresses CIDRs. Pools
/// enable you to organize your IP addresses according to your routing and
/// security needs. For example, if you have separate routing and security needs
/// for development and production applications, you can create a pool for each.
pub const IpamPool = struct {
    /// The address family of the pool.
    address_family: ?AddressFamily,

    /// The default netmask length for allocations added to this pool. If, for
    /// example, the CIDR assigned to this pool is 10.0.0.0/8 and
    /// you enter 16 here, new allocations will default to 10.0.0.0/16.
    allocation_default_netmask_length: ?i32,

    /// The maximum netmask length possible for CIDR allocations in this IPAM pool
    /// to be compliant. The maximum netmask length must be greater than the minimum
    /// netmask length. Possible netmask lengths for IPv4 addresses are 0 - 32.
    /// Possible netmask lengths for IPv6 addresses are 0 - 128.
    allocation_max_netmask_length: ?i32,

    /// The minimum netmask length required for CIDR allocations in this IPAM pool
    /// to be compliant. The minimum netmask length must be less than the maximum
    /// netmask length. Possible netmask lengths for IPv4 addresses are 0 - 32.
    /// Possible netmask lengths for IPv6 addresses are 0 - 128.
    allocation_min_netmask_length: ?i32,

    /// Tags that are required for resources that use CIDRs from this IPAM pool.
    /// Resources that do not have these tags will not be allowed to allocate space
    /// from the pool. If the resources have their tags changed after they have
    /// allocated space or if the allocation tagging requirements are changed on the
    /// pool, the resource may be marked as noncompliant.
    allocation_resource_tags: ?[]const IpamResourceTag,

    /// If selected, IPAM will continuously look for resources within the CIDR range
    /// of this pool
    /// and automatically import them as allocations into your IPAM. The CIDRs that
    /// will be allocated for
    /// these resources must not already be allocated to other resources in order
    /// for the import to succeed. IPAM will import
    /// a CIDR regardless of its compliance with the pool's allocation rules, so a
    /// resource might be imported and subsequently
    /// marked as noncompliant. If IPAM discovers multiple CIDRs that overlap, IPAM
    /// will import the largest CIDR only. If IPAM
    /// discovers multiple CIDRs with matching CIDRs, IPAM will randomly import one
    /// of them only.
    ///
    /// A locale must be set on the pool for this feature to work.
    auto_import: ?bool,

    /// Limits which service in Amazon Web Services that the pool can be used in.
    /// "ec2", for example, allows users to use space for Elastic IP addresses and
    /// VPCs.
    aws_service: ?IpamPoolAwsService,

    /// The description of the IPAM pool.
    description: ?[]const u8,

    /// The ARN of the IPAM.
    ipam_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the IPAM pool.
    ipam_pool_arn: ?[]const u8,

    /// The ID of the IPAM pool.
    ipam_pool_id: ?[]const u8,

    /// The Amazon Web Services Region of the IPAM pool.
    ipam_region: ?[]const u8,

    /// The ARN of the scope of the IPAM pool.
    ipam_scope_arn: ?[]const u8,

    /// In IPAM, a scope is the highest-level container within IPAM. An IPAM
    /// contains two default scopes. Each scope represents the IP space for a single
    /// network. The private scope is intended for all private IP address space. The
    /// public scope is intended for all public IP address space. Scopes enable you
    /// to reuse IP addresses across multiple unconnected networks without causing
    /// IP address overlap or conflict.
    ipam_scope_type: ?IpamScopeType,

    /// The locale of the IPAM pool.
    ///
    /// The locale for the pool should be one of the following:
    ///
    /// * An Amazon Web Services Region where you want this IPAM pool to be
    ///   available for allocations.
    ///
    /// * The network border group for an Amazon Web Services Local Zone where you
    ///   want this IPAM pool to be available for allocations ([supported Local
    ///   Zones](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-byoip.html#byoip-zone-avail)). This option is only available for IPAM IPv4 pools in the public scope.
    ///
    /// If you choose an Amazon Web Services Region for locale that has not been
    /// configured as an operating Region for the IPAM, you'll get an error.
    locale: ?[]const u8,

    /// The Amazon Web Services account ID of the owner of the IPAM pool.
    owner_id: ?[]const u8,

    /// The depth of pools in your IPAM pool. The pool depth quota is 10. For more
    /// information, see [Quotas in
    /// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/quotas-ipam.html) in the
    /// *Amazon VPC IPAM User Guide*.
    pool_depth: ?i32,

    /// The IP address source for pools in the public scope. Only used for
    /// provisioning IP address CIDRs to pools in the public scope. Default is
    /// `BYOIP`. For more information, see [Create IPv6
    /// pools](https://docs.aws.amazon.com/vpc/latest/ipam/intro-create-ipv6-pools.html) in the *Amazon VPC IPAM User Guide*.
    /// By default, you can add only one Amazon-provided IPv6 CIDR block to a
    /// top-level IPv6 pool. For information on increasing the default limit, see
    /// [Quotas for your
    /// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/quotas-ipam.html) in the
    /// *Amazon VPC IPAM User Guide*.
    public_ip_source: ?IpamPoolPublicIpSource,

    /// Determines if a pool is publicly advertisable. This option is not available
    /// for pools with AddressFamily set to `ipv4`.
    publicly_advertisable: ?bool,

    /// The ID of the source IPAM pool. You can use this option to create an IPAM
    /// pool within an existing source pool.
    source_ipam_pool_id: ?[]const u8,

    /// The resource used to provision CIDRs to a resource planning pool.
    source_resource: ?IpamPoolSourceResource,

    /// The state of the IPAM pool.
    state: ?IpamPoolState,

    /// The state message.
    state_message: ?[]const u8,

    /// The key/value combination of a tag assigned to the resource. Use the tag key
    /// in the filter name and the tag value as the filter value.
    /// For example, to find all resources that have a tag with the key `Owner` and
    /// the value `TeamA`, specify `tag:Owner` for the filter name and `TeamA` for
    /// the filter value.
    tags: ?[]const Tag,
};
