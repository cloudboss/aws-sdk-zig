/// Contains information about an overlapping route detected for a BYOIP prefix.
pub const IpamRouteOverlap = struct {
    /// The ASN originating the overlapping route.
    asn: ?[]const u8 = null,

    /// The time when the overlap was detected.
    detected_at: ?i64 = null,

    /// The overlapping IP address prefix in CIDR notation.
    prefix: ?[]const u8 = null,
};
