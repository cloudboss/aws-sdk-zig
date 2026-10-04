/// Contains information about a Route Origin Authorization (ROA) currently
/// published in the RPKI.
pub const IpamRouteOriginAuthorizationInfo = struct {
    /// The Autonomous System Number (ASN) authorized to originate the prefix.
    asn: ?[]const u8 = null,

    /// The IP address prefix in CIDR notation authorized by the ROA.
    cidr: ?[]const u8 = null,

    /// The maximum prefix length that the ASN is authorized to announce.
    max_length: ?i32 = null,
};
