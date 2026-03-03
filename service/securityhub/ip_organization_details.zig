/// Provides information about an internet provider.
pub const IpOrganizationDetails = struct {
    /// The Autonomous System Number (ASN) of the internet provider
    asn: ?i32 = null,

    /// The name of the organization that registered the ASN.
    asn_org: ?[]const u8 = null,

    /// The ISP information for the internet provider.
    isp: ?[]const u8 = null,

    /// The name of the internet provider.
    org: ?[]const u8 = null,

    pub const json_field_names = .{
        .asn = "Asn",
        .asn_org = "AsnOrg",
        .isp = "Isp",
        .org = "Org",
    };
};
