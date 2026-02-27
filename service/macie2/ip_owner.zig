/// Provides information about the registered owner of an IP address.
pub const IpOwner = struct {
    /// The autonomous system number (ASN) for the autonomous system that included
    /// the IP address.
    asn: ?[]const u8,

    /// The organization identifier that's associated with the autonomous system
    /// number (ASN) for the autonomous system that included the IP address.
    asn_org: ?[]const u8,

    /// The name of the internet service provider (ISP) that owned the IP address.
    isp: ?[]const u8,

    /// The name of the organization that owned the IP address.
    org: ?[]const u8,

    pub const json_field_names = .{
        .asn = "asn",
        .asn_org = "asnOrg",
        .isp = "isp",
        .org = "org",
    };
};
