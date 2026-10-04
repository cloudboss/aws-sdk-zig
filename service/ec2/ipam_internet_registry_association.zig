const Rir = @import("rir.zig").Rir;
const IpamInternetRegistryAssociationState = @import("ipam_internet_registry_association_state.zig").IpamInternetRegistryAssociationState;
const Tag = @import("tag.zig").Tag;

/// Contains information about an association between an IPAM and a Regional
/// Internet Registry (RIR) for delegated RPKI management.
pub const IpamInternetRegistryAssociation = struct {
    /// The XML content for the child request to be submitted to the internet
    /// registry to complete the BPKI setup.
    child_request_xml: ?[]const u8 = null,

    /// The description of the internet registry association.
    description: ?[]const u8 = null,

    /// The ID of the associated IPAM.
    ipam_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the internet registry association.
    ipam_internet_registry_association_arn: ?[]const u8 = null,

    /// The ID of the internet registry association.
    ipam_internet_registry_association_id: ?[]const u8 = null,

    /// The Amazon Web Services Region of the IPAM.
    ipam_region: ?[]const u8 = null,

    /// The organization handle at the internet registry.
    organization_handle: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that owns the internet registry
    /// association.
    owner_id: ?[]const u8 = null,

    /// The Regional Internet Registry. Possible values:
    ///
    /// * `ripe` - RIPE NCC (Europe, the Middle East, and Central Asia).
    ///
    /// * `apnic` - APNIC (Asia Pacific).
    ///
    /// * `arin` - ARIN (North America).
    ///
    /// * `lacnic` - LACNIC (Latin America and the Caribbean).
    rir: ?Rir = null,

    /// The state of the internet registry association. Valid values:
    /// `pending-activation` | `pending-enable` | `create-in-progress` |
    /// `create-failed` | `enable-in-progress` | `enable-complete` | `enable-failed`
    /// | `delete-in-progress` | `delete-complete` | `delete-failed`.
    state: ?IpamInternetRegistryAssociationState = null,

    /// A message describing the current state of the internet registry association,
    /// including additional details such as the reason for a failure.
    state_message: ?[]const u8 = null,

    /// The tags assigned to the internet registry association.
    tags: ?[]const Tag = null,
};
