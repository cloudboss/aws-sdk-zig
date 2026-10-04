/// Contains information about a Route Origin Authorization (ROA) published in
/// the RPKI. A ROA cryptographically attests that a specific ASN is authorized
/// to originate a specific IP address prefix.
pub const IpamRouteOriginAuthorization = struct {
    /// The Autonomous System Number (ASN) authorized by the ROA.
    asn: ?[]const u8 = null,

    /// The expiration date of the ROA.
    expiration: ?i64 = null,

    /// Specifies whether the ROA matches the route announcement.
    match: ?bool = null,

    /// The maximum prefix length that the ASN is authorized to announce.
    max_length: ?i32 = null,

    /// The IP address prefix authorized by the ROA in CIDR notation.
    prefix: ?[]const u8 = null,
};
