const IpamOperatingRegion = @import("ipam_operating_region.zig").IpamOperatingRegion;
const IpamOrganizationalUnitExclusion = @import("ipam_organizational_unit_exclusion.zig").IpamOrganizationalUnitExclusion;
const IpamResourceDiscoveryState = @import("ipam_resource_discovery_state.zig").IpamResourceDiscoveryState;
const Tag = @import("tag.zig").Tag;

/// A resource discovery is an IPAM component that enables IPAM to manage and
/// monitor resources that belong to the owning account.
pub const IpamResourceDiscovery = struct {
    /// The resource discovery description.
    description: ?[]const u8,

    /// The resource discovery Amazon Resource Name (ARN).
    ipam_resource_discovery_arn: ?[]const u8,

    /// The resource discovery ID.
    ipam_resource_discovery_id: ?[]const u8,

    /// The resource discovery Region.
    ipam_resource_discovery_region: ?[]const u8,

    /// Defines if the resource discovery is the default. The default resource
    /// discovery is the resource discovery automatically created when you create an
    /// IPAM.
    is_default: ?bool,

    /// The operating Regions for the resource discovery. Operating Regions are
    /// Amazon Web Services Regions where the IPAM is allowed to manage IP address
    /// CIDRs. IPAM only discovers and monitors resources in the Amazon Web Services
    /// Regions you select as operating Regions.
    operating_regions: ?[]const IpamOperatingRegion,

    /// If your IPAM is integrated with Amazon Web Services Organizations and you
    /// add an organizational unit (OU) exclusion, IPAM will not manage the IP
    /// addresses in accounts in that OU exclusion.
    organizational_unit_exclusions: ?[]const IpamOrganizationalUnitExclusion,

    /// The ID of the owner.
    owner_id: ?[]const u8,

    /// The lifecycle state of the resource discovery.
    ///
    /// * `create-in-progress` - Resource discovery is being created.
    ///
    /// * `create-complete` - Resource discovery creation is complete.
    ///
    /// * `create-failed` - Resource discovery creation has failed.
    ///
    /// * `modify-in-progress` - Resource discovery is being modified.
    ///
    /// * `modify-complete` - Resource discovery modification is complete.
    ///
    /// * `modify-failed` - Resource discovery modification has failed.
    ///
    /// * `delete-in-progress` - Resource discovery is being deleted.
    ///
    /// * `delete-complete` - Resource discovery deletion is complete.
    ///
    /// * `delete-failed` - Resource discovery deletion has failed.
    ///
    /// * `isolate-in-progress` - Amazon Web Services account that created the
    ///   resource discovery has been removed and the resource discovery is being
    ///   isolated.
    ///
    /// * `isolate-complete` - Resource discovery isolation is complete.
    ///
    /// * `restore-in-progress` - Amazon Web Services account that created the
    ///   resource discovery and was isolated has been restored.
    state: ?IpamResourceDiscoveryState,

    /// A tag is a label that you assign to an Amazon Web Services resource. Each
    /// tag consists of a key and an optional value. You can use tags to search and
    /// filter your resources or track your Amazon Web Services costs.
    tags: ?[]const Tag,
};
