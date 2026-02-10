const IpamMeteredAccount = @import("ipam_metered_account.zig").IpamMeteredAccount;
const IpamOperatingRegion = @import("ipam_operating_region.zig").IpamOperatingRegion;
const IpamState = @import("ipam_state.zig").IpamState;
const Tag = @import("tag.zig").Tag;
const IpamTier = @import("ipam_tier.zig").IpamTier;

/// IPAM is a VPC feature that you can use to automate your IP address
/// management workflows including assigning, tracking, troubleshooting, and
/// auditing IP addresses across Amazon Web Services Regions and accounts
/// throughout your Amazon Web Services Organization. For more information, see
/// [What is
/// IPAM?](https://docs.aws.amazon.com/vpc/latest/ipam/what-is-it-ipam.html) in
/// the *Amazon VPC IPAM User Guide*.
pub const Ipam = struct {
    /// The IPAM's default resource discovery association ID.
    default_resource_discovery_association_id: ?[]const u8,

    /// The IPAM's default resource discovery ID.
    default_resource_discovery_id: ?[]const u8,

    /// The description for the IPAM.
    description: ?[]const u8,

    /// Enable this option to use your own GUA ranges as private IPv6 addresses.
    /// This option is disabled by default.
    enable_private_gua: ?bool,

    /// The Amazon Resource Name (ARN) of the IPAM.
    ipam_arn: ?[]const u8,

    /// The ID of the IPAM.
    ipam_id: ?[]const u8,

    /// The Amazon Web Services Region of the IPAM.
    ipam_region: ?[]const u8,

    /// A metered account is an Amazon Web Services account that is charged for
    /// active IP addresses managed in IPAM. For more information, see [Enable cost
    /// distribution](https://docs.aws.amazon.com/vpc/latest/ipam/ipam-enable-cost-distro.html) in the *Amazon VPC IPAM User Guide*.
    ///
    /// Possible values:
    ///
    /// * `ipam-owner` (default): The Amazon Web Services account which owns the
    ///   IPAM is charged for all active IP addresses managed in IPAM.
    ///
    /// * `resource-owner`: The Amazon Web Services account that owns the IP address
    ///   is charged for the active IP address.
    metered_account: ?IpamMeteredAccount,

    /// The operating Regions for an IPAM. Operating Regions are Amazon Web Services
    /// Regions where the IPAM is allowed to manage IP address CIDRs. IPAM only
    /// discovers and monitors resources in the Amazon Web Services Regions you
    /// select as operating Regions.
    ///
    /// For more information about operating Regions, see [Create an
    /// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/create-ipam.html) in the
    /// *Amazon VPC IPAM User Guide*.
    operating_regions: ?[]const IpamOperatingRegion,

    /// The Amazon Web Services account ID of the owner of the IPAM.
    owner_id: ?[]const u8,

    /// The ID of the IPAM's default private scope.
    private_default_scope_id: ?[]const u8,

    /// The ID of the IPAM's default public scope.
    public_default_scope_id: ?[]const u8,

    /// The IPAM's resource discovery association count.
    resource_discovery_association_count: ?i32,

    /// The number of scopes in the IPAM. The scope quota is 5. For more information
    /// on quotas, see [Quotas in
    /// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/quotas-ipam.html) in the
    /// *Amazon VPC IPAM User Guide*.
    scope_count: ?i32,

    /// The state of the IPAM.
    state: ?IpamState,

    /// The state message.
    state_message: ?[]const u8,

    /// The key/value combination of a tag assigned to the resource. Use the tag key
    /// in the filter name and the tag value as the filter value.
    /// For example, to find all resources that have a tag with the key `Owner` and
    /// the value `TeamA`, specify `tag:Owner` for the filter name and `TeamA` for
    /// the filter value.
    tags: ?[]const Tag,

    /// IPAM is offered in a Free Tier and an Advanced Tier. For more information
    /// about the features available in each tier and the costs associated with the
    /// tiers, see [Amazon VPC pricing > IPAM
    /// tab](http://aws.amazon.com/vpc/pricing/).
    tier: ?IpamTier,
};
