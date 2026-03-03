const IpamAssociatedResourceDiscoveryStatus = @import("ipam_associated_resource_discovery_status.zig").IpamAssociatedResourceDiscoveryStatus;
const IpamResourceDiscoveryAssociationState = @import("ipam_resource_discovery_association_state.zig").IpamResourceDiscoveryAssociationState;
const Tag = @import("tag.zig").Tag;

/// An IPAM resource discovery association. An associated resource discovery is
/// a resource discovery that has been associated with an IPAM. IPAM aggregates
/// the resource CIDRs discovered by the associated resource discovery.
pub const IpamResourceDiscoveryAssociation = struct {
    /// The IPAM ARN.
    ipam_arn: ?[]const u8 = null,

    /// The IPAM ID.
    ipam_id: ?[]const u8 = null,

    /// The IPAM home Region.
    ipam_region: ?[]const u8 = null,

    /// The resource discovery association Amazon Resource Name (ARN).
    ipam_resource_discovery_association_arn: ?[]const u8 = null,

    /// The resource discovery association ID.
    ipam_resource_discovery_association_id: ?[]const u8 = null,

    /// The resource discovery ID.
    ipam_resource_discovery_id: ?[]const u8 = null,

    /// Defines if the resource discovery is the default. When you create an IPAM, a
    /// default resource discovery is created for your IPAM and it's associated with
    /// your IPAM.
    is_default: ?bool = null,

    /// The Amazon Web Services account ID of the resource discovery owner.
    owner_id: ?[]const u8 = null,

    /// The resource discovery status.
    ///
    /// * `active` - Connection or permissions required to read the
    /// results of the resource discovery are intact.
    ///
    /// * `not-found` - Connection or permissions required to read the
    /// results of the resource discovery are broken. This may happen if the owner
    /// of the resource discovery stopped sharing it or deleted the resource
    /// discovery. Verify the resource discovery still exists and the Amazon Web
    /// Services RAM resource share is still intact.
    resource_discovery_status: ?IpamAssociatedResourceDiscoveryStatus = null,

    /// The lifecycle state of the association when you associate or disassociate a
    /// resource discovery.
    ///
    /// * `associate-in-progress` - Resource discovery is being associated.
    ///
    /// * `associate-complete` - Resource discovery association is complete.
    ///
    /// * `associate-failed` - Resource discovery association has failed.
    ///
    /// * `disassociate-in-progress` - Resource discovery is being disassociated.
    ///
    /// * `disassociate-complete` - Resource discovery disassociation is complete.
    ///
    /// * `disassociate-failed ` - Resource discovery disassociation has failed.
    ///
    /// * `isolate-in-progress` - Amazon Web Services account that created the
    ///   resource discovery association has been removed and the resource discovery
    ///   association is being isolated.
    ///
    /// * `isolate-complete` - Resource discovery isolation is complete.
    ///
    /// * `restore-in-progress` - Resource discovery is being restored.
    state: ?IpamResourceDiscoveryAssociationState = null,

    /// A tag is a label that you assign to an Amazon Web Services resource. Each
    /// tag consists of a key and an optional value. You can use tags to search and
    /// filter your resources or track your Amazon Web Services costs.
    tags: ?[]const Tag = null,
};
