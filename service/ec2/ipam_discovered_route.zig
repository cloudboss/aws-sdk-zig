const IpamByoipAdvertisementType = @import("ipam_byoip_advertisement_type.zig").IpamByoipAdvertisementType;
const IpamByoipCidrState = @import("ipam_byoip_cidr_state.zig").IpamByoipCidrState;

/// Contains information about a BGP route discovered by IPAM resource
/// discovery.
pub const IpamDiscoveredRoute = struct {
    /// The advertisement type of the route. Possible values:
    ///
    /// * `regional` - The IP address is advertised from a single location (regional
    ///   services such as Amazon EC2).
    ///
    /// * `global` - The IP address is advertised from multiple global locations
    ///   simultaneously (global services such as Amazon CloudFront).
    advertisement_type: ?IpamByoipAdvertisementType = null,

    /// The Autonomous System Number (ASN) that originates the route.
    asn: ?[]const u8 = null,

    /// The IP address prefix of the discovered route in CIDR notation.
    cidr: ?[]const u8 = null,

    /// The ID of the IPAM pool associated with the route.
    ipam_pool_id: ?[]const u8 = null,

    /// The ID of the IPAM resource discovery that discovered the route.
    ipam_resource_discovery_id: ?[]const u8 = null,

    /// The network border group for the route.
    network_border_group: ?[]const u8 = null,

    /// The ID of the BYOIP pool associated with the route.
    pool_id: ?[]const u8 = null,

    /// The ID of the resource owner.
    resource_owner_id: ?[]const u8 = null,

    /// The Amazon Web Services Region where the route was discovered.
    resource_region: ?[]const u8 = null,

    /// The time when the route was last sampled.
    sample_time: ?i64 = null,

    /// The state of the BYOIP CIDR. Possible values:
    ///
    /// * `advertised` - The CIDR is being advertised.
    ///
    /// * `deprovisioned` - The CIDR has been deprovisioned.
    ///
    /// * `failed-deprovision` - Deprovisioning failed.
    ///
    /// * `failed-provision` - Provisioning failed.
    ///
    /// * `pending-deprovision` - Deprovisioning is in progress.
    ///
    /// * `pending-provision` - Provisioning is in progress.
    ///
    /// * `provisioned` - The CIDR is provisioned.
    ///
    /// * `provisioned-not-publicly-advertisable` - The CIDR is provisioned but not
    ///   publicly advertisable.
    state: ?IpamByoipCidrState = null,
};
