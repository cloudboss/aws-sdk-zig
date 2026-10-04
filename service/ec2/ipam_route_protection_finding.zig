const IpamByoipAdvertisementType = @import("ipam_byoip_advertisement_type.zig").IpamByoipAdvertisementType;
const IpamRouteOriginAuthorization = @import("ipam_route_origin_authorization.zig").IpamRouteOriginAuthorization;
const IpamRouteOverlap = @import("ipam_route_overlap.zig").IpamRouteOverlap;
const IpamRpkiStatus = @import("ipam_rpki_status.zig").IpamRpkiStatus;
const IpamRpkiStrength = @import("ipam_rpki_strength.zig").IpamRpkiStrength;
const IpamByoipCidrState = @import("ipam_byoip_cidr_state.zig").IpamByoipCidrState;

/// Contains information about a route protection finding, including the RPKI
/// validation status of a BYOIP route announcement.
pub const IpamRouteProtectionFinding = struct {
    /// The advertisement type. Possible values:
    ///
    /// * `regional` - The IP address is advertised from a single location (regional
    ///   services such as Amazon EC2).
    ///
    /// * `global` - The IP address is advertised from multiple global locations
    ///   simultaneously (global services such as Amazon CloudFront).
    advertisement_type: ?IpamByoipAdvertisementType = null,

    /// The Autonomous System Number (ASN) that originates the route.
    asn: ?[]const u8 = null,

    /// The IP address prefix in CIDR notation.
    cidr: ?[]const u8 = null,

    /// The ID of the IPAM pool associated with the finding.
    ipam_pool_id: ?[]const u8 = null,

    /// The network border group.
    network_border_group: ?[]const u8 = null,

    /// The ID of the BYOIP pool.
    pool_id: ?[]const u8 = null,

    /// The ID of the resource owner.
    resource_owner_id: ?[]const u8 = null,

    /// The Amazon Web Services Region of the resource.
    resource_region: ?[]const u8 = null,

    /// The Route Origin Authorizations (ROAs) that cover the prefix.
    roas: ?[]const IpamRouteOriginAuthorization = null,

    /// The time when the ROA data was last sampled.
    roa_sample_time: ?i64 = null,

    /// The overlapping routes detected for this prefix.
    route_overlaps: ?[]const IpamRouteOverlap = null,

    /// The RPKI validation status of the route. Possible values:
    ///
    /// * `valid` - The route has a matching ROA that covers the prefix and origin
    ///   ASN.
    ///
    /// * `invalid` - The route has a ROA for the prefix, but the origin ASN or
    ///   prefix length does not match.
    ///
    /// * `unknown` - No ROA exists for the prefix, so RPKI validation cannot be
    ///   performed.
    rpki_status: ?IpamRpkiStatus = null,

    /// The RPKI enforcement strength for the route. Possible values:
    ///
    /// * `strict` - Invalid routes are rejected.
    ///
    /// * `permissive` - Invalid routes are accepted but flagged.
    rpki_strength: ?IpamRpkiStrength = null,

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
